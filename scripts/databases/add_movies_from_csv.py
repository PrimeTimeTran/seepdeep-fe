import pandas as pd
import sqlite3
csv_file_path = './PixarMovies.csv'
db_file_path = './alpha.db'

df = pd.read_csv(csv_file_path)
df.fillna({
    'Length': 0,
    'Opening Weekend': 0,
    'Domestic Gross': 0,
    'Adjusted Domestic Gross': 0,
    'International Gross': 0,
    'Production Budget': 0,
    'Oscars Nominated': 0,
    'Oscars Won': 0
}, inplace=True)

conn = sqlite3.connect(db_file_path)
df.to_sql('movies', conn, if_exists='append', index=False)
conn.close()
