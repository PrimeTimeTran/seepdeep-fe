import pandas as pd
import requests
import time
import sqlite3
from add_liveactionmovies import export_tables_to_csv

db_file_path = '../database.db'


def update_film_desc_where_can():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()

    conn.commit()
    conn.close()


export_tables_to_csv('.')
