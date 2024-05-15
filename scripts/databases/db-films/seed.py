import csv
import pandas as pd
import requests
import time
import sqlite3
from add_liveactionmovies import export_tables_to_csv
from update_posters import update_film_from_api, update_film_records

db_file_path = '../database.db'

# Oscar categories
oscar_categories = ['ACTOR IN A LEADING ROLE', 'ACTOR IN A SUPPORTING ROLE', 'ACTRESS IN A LEADING ROLE', 'ACTRESS IN A SUPPORTING ROLE', 'ANIMATED FEATURE FILM',
                    'CINEMATOGRAPHY'
                    'COSTUME DESIGN',
                    'DIRECTING',
                    'DOCUMENTARY FEATURE FILM',
                    'DOCUMENTARY SHORT FILM',
                    'FILM EDITING',
                    'INTERNATIONAL FEATURE FILM',
                    'MAKEUP AND HAIRSTYLING',
                    'MUSIC (Original Score)',
                    'MUSIC (Original Song)',
                    'BEST PICTURE',
                    'PRODUCTION DESIGN',
                    'SHORT FILM (Animated)',
                    'SHORT FILM (Live Action)',
                    'SOUND',
                    'VISUAL EFFECTS',
                    'WRITING (Adapted Screenplay)',
                    'WRITING (Original Screenplay)',
                    ]


def add_oscars():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_table_query = """
        CREATE TABLE IF NOT EXISTS oscars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            film TEXT,
            name TEXT,
            year_ceremony INTEGER,
            category TEXT,
            film_id INTEGER,
            ceremony INTEGER,
            winner BOOL,
            FOREIGN KEY (film_id) REFERENCES films(id)
        );
    """
    cursor.execute(create_table_query)
    file = 'the_oscar_award.csv'
    with open(file, 'r', newline='') as csvfile:
        csv_reader = csv.DictReader(csvfile)
        for row in csv_reader:
            cursor.execute(
                '''SELECT * FROM films WHERE title = ? AND year = ?''', (row['film'], row['year_film']))
            existing_film = cursor.fetchone()
            print(existing_film)
            if existing_film is not None:
                film_id = existing_film[0]
                name = row['name']
                ceremony = row['ceremony']
                year_ceremony = row['year_ceremony']
                category = row['category']
                winner = row['winner']
                cursor.execute('''INSERT INTO oscars (
                                film, 
                                film_id,
                                name, 
                                ceremony, 
                                year_ceremony,
                                category,
                                winner
                               ) 
                                VALUES (?, ?, ?, ?, ?, ?, ?)
                               ''', (row['film'], film_id, name, ceremony, year_ceremony, category, winner))
    conn.commit()
    conn.close()


add_oscars()
# update_film_from_api('./films.csv')
# update_film_records(db_file_path, 'films.csv')
# export_tables_to_csv('.')
