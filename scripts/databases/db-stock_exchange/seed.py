import pandas as pd
import sqlite3

db_file_path = 'stocks.db'
conn = sqlite3.connect(db_file_path)
cur = conn.cursor()

def export_tables_to_csv():
    tables = ['Companies', 'Assets', 'AssetPrices', 'Orders',
              'OrderBooks', 'Users', 'Accounts', 'Transfers']
    for table in tables:
        query = f"SELECT * FROM {table};"
        df = pd.read_sql(query, conn)
        csv_file_path = f"./{table}.csv"
        df.to_csv(csv_file_path, index=False)
    print(
        f"Tables have been exported to '{csv_file_path}' as separate sheets.")

def seed_exchanges():
    print('Seeding Exchanges')
    exchanges = [
        {
            'name': 'Nasdaq',
            'description': 'The Nasdaq Stock Market is an American stock exchange based in New York City.',
            'founded': '1971-02-08',
            'market_cap': None
        },
        {
            'name': 'NYSE',
            'description': 'The New York Stock Exchange is an American stock exchange located in New York City.',
            'founded': '1792-05-17',
            'market_cap': None
        }
    ]
    for exchange in exchanges:
        cur.execute('''
            INSERT INTO Exchanges (name, description, founded, market_cap)
            VALUES (?, ?, ?, ?)
        ''', (exchange['name'], exchange['description'], exchange['founded'], exchange['market_cap']))

def seed_companies():
    print('Seeding Companies')

seed_exchanges()
seed_companies()
export_tables_to_csv()

conn.commit()
conn.close()
