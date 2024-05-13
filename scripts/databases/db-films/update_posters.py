import pandas as pd
import requests
import time
import sqlite3

api_key = '9afedb36'
def update_posters(path):
    df = pd.read_csv(path)
    base_url = "http://www.omdbapi.com/"
    df_subset = df.head(56)
    for index, row in df_subset.iterrows():
        movie_title = row['title'].replace(' ', '+')
        api_url = f"{base_url}?t={movie_title}&apikey={api_key}"
        response = requests.get(api_url)
        time.sleep(1)
        if response.status_code == 200:
            data = response.json()
            poster_url = data.get('Poster', '')
            df.at[index, 'url_poster'] = poster_url
        else:
            print(f"Failed to fetch poster URL for {row['title']} (HTTP {response.status_code})")
    df.to_csv(path, index=False)
    print(f"Updated {len(df)} records with poster URLs.")
# update_posters('./films.csv')

def update_poster_in_db(db_file_path, csv_file_path):
    df = pd.read_csv(csv_file_path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    for index, row in df.iterrows():
        movie_id = row['id']
        poster_url = row['url_poster']
        overview = row['overview']
        cursor.execute("UPDATE films SET url_poster = ?, overview = ? WHERE id = ?", (poster_url, overview, movie_id))
    conn.commit()
    cursor.close()
    conn.close()
    
    print(f"Updated {len(df)} records in the database with poster URLs.")

update_poster_in_db('./database.db', './films.csv')