import json
import pandas as pd
import sqlite3
from bs4 import BeautifulSoup

db_file_path = 'stocks.db'
conn = sqlite3.connect(db_file_path)
cur = conn.cursor()

def safe_parse_na(text):
    if text == 'N/A':
        return None
    else:
        text = text.replace(',', '').replace('$', '')
        if text.endswith('%'):
            return round(float(text[:-1]), 2)
        else:
            return round(float(text), 2)

def safe_parse_thousands(text):
    if text.endswith('k'):
        number_str = text[:-1]
        return float(number_str.replace('$', '').replace(',', '')) * 1000
    else:
        return float(text.replace('$', '').replace(',', ''))

def scrape():
    items = []
    for i in range(1, 11):
        for j in range(1, 6):
            # Scrape by URL
            # page = f"https://www.wallstreetzen.com/stock-screener/?t={j}&p={i}&s=mc&sd=desc"
            # Scrape by local
            page_path = f"./wallstreetzen-{i}-{j}.html"
            with open(page_path, 'r') as file:
                page_content = file.read()

            soup = BeautifulSoup(page_content, 'html.parser')
            if j == 1:
                print('Grab OverView')
                tbody_element = soup.find(
                    'tbody', {'class': 'MuiTableBody-root-490'})
                if tbody_element:
                    tr_elements = tbody_element.find_all('tr')
                    
                    for _, tr in enumerate(tr_elements):
                        td_elements = tr.find_all('td')
                        symbol = td_elements[0].find('a').get_text()
                        item = {}
                        jdx = 0
                        # print(f"symbol {symbol}")
                        for td in td_elements:
                            span = td.find('span')
                            if span:
                                # print(
                                #     f"Span innerHTML {jdx}: {span.get_text()}")
                                if jdx == 7:
                                    item['change_1_day'] = safe_parse_na(span.get_text())
                            else:
                                # print(
                                #     f"TD innerHTML {jdx}: {td.get_text()}")
                                val = td.get_text()
                                if jdx == 0:
                                    item['sym'] = val
                                if jdx == 1:
                                    item['name'] = val
                                if jdx == 2:
                                    item['exchange'] = 1 if val == 'NYSE' else 2
                                if jdx == 3:
                                    item['industry'] = val
                                if jdx == 5:
                                    item['mc'] = val
                                if jdx == 6:
                                    item['price'] = float(val.replace('$', '').replace(',', ''))
                                if jdx == 8:
                                    item['ebitda'] = val
                                if jdx == 9:
                                    item['pe'] = val
                                if jdx == 10:
                                    item['de'] = safe_parse_na(val)
                            jdx += 1
                        items.append(item.copy())
            if j == 2:
            # if j == 2 and False:
                print('Grab Price')
                tbody_element = soup.find(
                    'tbody', {'class': 'MuiTableBody-root-490'})
                if tbody_element:
                    tr_elements = tbody_element.find_all('tr')
                    for _, tr in enumerate(tr_elements):
                        td_elements = tr.find_all('td')
                        symbol = td_elements[0].find('a').get_text()
                        index = None
                        for item_idx, item in enumerate(items):
                            if item['sym'] == symbol:
                                index = item_idx
                                break
                        jdx = 0
                        # print(f'index symbol {symbol} {index}')
                        for td in td_elements:
                            span = td.find('span')
                            if span:
                                # print(
                                #     f"Span innerHTML {jdx}: {span.get_text()}")
                                val = safe_parse_na(span.get_text())
                                if jdx == 3:
                                    items[index]['change_1_day'] = val
                                if jdx == 4:
                                    items[index]['change_1_week'] = val
                                if jdx == 5:
                                    items[index]['change_1_month'] = val
                                if jdx == 6:
                                    items[index]['change_3_month'] = val
                                if jdx == 7:
                                    items[index]['change_6_month'] = val
                                if jdx == 8:
                                    items[index]['change_1_year'] = val
                                if jdx == 9:
                                    items[index]['change_3_year'] = val
                                if jdx == 10:
                                    items[index]['change_5_year'] = val
                                if jdx == 11:
                                    items[index]['change_10_year'] = val
                                if jdx == 14:
                                    items[index]['change_year_hi'] = val
                                if jdx == 15:
                                    items[index]['change_year_lo'] = val
                            else:
                                # print(
                                #     f"TD innerHTML {jdx}: {td.get_text()}")
                                if jdx == 12:
                                    items[index]['year_hi'] = safe_parse_thousands(td.get_text())
                                if jdx == 13:
                                    items[index]['year_lo'] = safe_parse_thousands(td.get_text())
                                if jdx == 17:
                                    items[index]['volume'] = int(safe_parse_thousands(td.get_text()))
                            jdx += 1
            if j == 3:
                print('Grab Dividend')
                tbody_element = soup.find(
                    'tbody', {'class': 'MuiTableBody-root-490'})
                if tbody_element:
                    tr_elements = tbody_element.find_all('tr')
                    for _, tr in enumerate(tr_elements):
                        td_elements = tr.find_all('td')
                        symbol = td_elements[0].find('a').get_text()
                        index = None
                        for item_idx, item in enumerate(items):
                            if item['sym'] == symbol:
                                index = item_idx
                                break
                        jdx = 0
                        for td in td_elements:
                            span = td.find('span')
                            if span:
                                # print(
                                #     f"Span innerHTML {jdx}: {span.get_text()}")
                                if jdx == 5:
                                    items[index]['po_ratio'] = safe_parse_na(span.get_text())
                            else:
                                # print(
                                #     f"TD innerHTML {jdx}: {td.get_text()}")
                                if jdx == 4:
                                    items[index]['dy'] = safe_parse_na(td.get_text())
                                if jdx == 6:
                                    items[index]['div_last'] = safe_parse_na(td.get_text())
                                if jdx == 7:
                                    items[index]['div_annual'] = safe_parse_na(td.get_text())
                                if jdx == 8:
                                    items[index]['div_percent'] = safe_parse_na(td.get_text())
                                if jdx == 9:
                                    items[index]['div_dropped'] = None if td.get_text() == 'N/A' else int(td.get_text())
                                if jdx == 10:
                                    items[index]['ex_div_date'] = td.get_text()
                                if jdx == 11:
                                    items[index]['div_payment_date'] = td.get_text()
                            jdx += 1
            if j == 4:
                print('Grab Earnings & Revenue')
                tbody_element = soup.find(
                    'tbody', {'class': 'MuiTableBody-root-490'})
                if tbody_element:
                    tr_elements = tbody_element.find_all('tr')
                    for _, tr in enumerate(tr_elements):
                        td_elements = tr.find_all('td')
                        symbol = td_elements[0].find('a').get_text()
                        print(f"symbol {symbol}")
                        index = None
                        for item_idx, item in enumerate(items):
                            if item['sym'] == symbol:
                                index = item_idx
                                break
                        
                        jdx = 0
                        for td in td_elements:
                            span = td.find('span')
                            if span:
                                print(
                                    f"Span innerHTML {jdx}: {span.get_text()}")
                                if jdx == 8:
                                    items[index]['revenue_growth_yoy'] = safe_parse_na(span.get_text())
                                if jdx == 9:
                                    items[index]['revenue_growth_5y'] = safe_parse_na(span.get_text())
                                if jdx == 10:
                                    items[index]['earnings_growth_yoy'] = safe_parse_na(span.get_text())
                                if jdx == 11:
                                    items[index]['earnings_growth_5y'] = safe_parse_na(span.get_text())
                            else:
                                print(
                                    f"TD innerHTML {jdx}: {td.get_text()}")
                                if jdx == 4:
                                    items[index]['revenue'] = td.get_text()
                                if jdx == 6:
                                    items[index]['earnings'] = td.get_text()
                                if jdx == 7:
                                    items[index]['eps'] = safe_parse_na(td.get_text())
                                
                            jdx += 1
            if j == 5:
                print('Grab Earnings & Revenue')
                tbody_element = soup.find(
                    'tbody', {'class': 'MuiTableBody-root-490'})
                if tbody_element:
                    tr_elements = tbody_element.find_all('tr')
                    for _, tr in enumerate(tr_elements):
                        td_elements = tr.find_all('td')
                        symbol = td_elements[0].find('a').get_text()
                        print(f"symbol {symbol}")
                        index = None
                        for item_idx, item in enumerate(items):
                            if item['sym'] == symbol:
                                index = item_idx
                                break
                        
                        jdx = 0
                        # View one at a time
                        # isOne = symbol == 'MSFT'
                        # if isOne:
                            # print(f'isOne {isOne}')
                        for td in td_elements:
                            span = td.find('span')
                            if span:
                                print(
                                    f"Span innerHTML {jdx}: {span.get_text()}")
                                # if jdx == 5:
                                #     items[index]['po_ratio'] = safe_parse_na(span.get_text())
                            else:
                                print(
                                    f"TD innerHTML {jdx}: {td.get_text()}")
                                if jdx == 2:
                                    items[index]['country'] = td.get_text()
                                if jdx == 4:
                                    items[index]['shares'] = int(safe_parse_na(td.get_text()))
                                if jdx == 5:
                                    items[index]['institutional'] = safe_parse_na(td.get_text())
                                if jdx == 6:
                                    items[index]['insider'] = safe_parse_na(td.get_text())
                                
                            jdx += 1
    items_json_str = json.dumps(items, indent=4)
    with open('stocks.json', 'w') as file:
        file.write(items_json_str)

scrape()
conn.commit()
conn.close()
