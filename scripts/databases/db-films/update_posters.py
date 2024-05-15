import pandas as pd
import requests
import time
import sqlite3

api_key = '9afedb36'
def update_film_from_api(path):
    df = pd.read_csv(path)
    base_url = "http://www.omdbapi.com/"
    df_subset = df[(df['id'] >= 1034) & (df['id'] <= 1070)]
    for index, row in df_subset.iterrows():
        movie_title = row['title'].replace(' ', '+')
        api_url = f"{base_url}?t={movie_title}&apikey={api_key}"
        response = requests.get(api_url)
        print(f'Updating film {movie_title}')
        time.sleep(1)
        # id,year,title,runtime,rt_score,imdb_score,metacritic_score,budget,worldwide_gross,domestic_gross,international_gross,oscars_won,oscars_nominated,overview,url_poster,studio_id
        data = response.json()
        if (data.get('BoxOffice','') != 'N/A' and data.get('BoxOffice','') != ''):
            worldwide_gross = int(data.get('BoxOffice','').replace('$', '').replace(',', ''))
            formatted_gross = '{:,.1f}'.format(worldwide_gross / 1000000)
            df.at[index, 'worldwide_gross'] = float(formatted_gross.replace(',', ''))

            poster_url = data.get('Poster', '')
            df.at[index, 'url_poster'] = poster_url

            desc = data.get('Plot','')
            df.at[index, 'overview'] = desc

            if (len(data.get('Ratings',[])) > 0 and data.get('Ratings',[])[0] is not None):
                imdb_score = data.get('Ratings',[])[0]
                df.at[index, 'imdb_score'] = float(imdb_score['Value'].split('/')[0])

            if (len(data.get('Ratings',[])) > 1 and data.get('Ratings',[])[1] is not None):
                rt_score = data.get('Ratings',[])[1]
                df.at[index, 'rt_score'] = float(rt_score['Value'].replace('%', ''))

            if (len(data.get('Ratings',[])) > 2 and data.get('Ratings',[])[2] is not None):
                metacritic_score = data.get('Ratings',[])[2]
                df.at[index, 'metacritic_score'] = float(metacritic_score['Value'].split('/')[0])
        else:
            print(f"Failed to fetch data for film {row['title']} (HTTP {response.status_code})")
    df.to_csv(path, index=False)
    print(f"Updated {len(df_subset)} records with poster URLs.")

def update_film_records(db_file_path, csv_file_path):
    df = pd.read_csv(csv_file_path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    for index, row in df.iterrows():
        movie_id = row['id']
        rt_score = row['rt_score']
        imdb_score = row['imdb_score']
        metacritic_score = row['metacritic_score']
        budget = row['budget']
        worldwide_gross = row['worldwide_gross']
        international_gross = row['international_gross']
        overview = row['overview']
        url_poster = row['url_poster']
        cursor.execute("""UPDATE films SET 
                       rt_score = ?, 
                       imdb_score = ?,
                       metacritic_score = ?, 
                       worldwide_gross = ?, 
                       budget = ?, 
                       international_gross = ?, 
                       overview = ?,
                       url_poster = ?
                       WHERE id = ?""", (rt_score, imdb_score, metacritic_score, worldwide_gross, budget, international_gross, overview,url_poster, movie_id))
    conn.commit()
    cursor.close()
    conn.close()
    
    print(f"Updated {len(df)} records in the database with poster URLs.")
