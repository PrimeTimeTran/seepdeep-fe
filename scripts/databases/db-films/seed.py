import pandas as pd
import requests
import time
import sqlite3
from add_liveactionmovies import export_tables_to_csv
from update_posters import update_film_from_api, update_film_records

db_file_path = '../database.db'

def update_film_desc_where_can():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()

    conn.commit()
    conn.close()
# update_film_from_api('./films.csv')
# update_film_records(db_file_path, 'films.csv')
export_tables_to_csv('.')
