import csv
import sqlite3

# List of films for studios?

# Universal
# https://simple.wikipedia.org/wiki/List_of_Universal_Pictures_movies

# Disney
# https://en.wikipedia.org/wiki/List_of_Walt_Disney_Pictures_films

# Paramount
# https://simple.wikipedia.org/wiki/List_of_Paramount_Pictures_movies

# Not so good below

# Warner brothers
# https://en.wikipedia.org/wiki/Lists_of_Warner_Bros._films

# 20th century
# https://en.wikipedia.org/wiki/Lists_of_20th_Century_Studios_films

# Columbia
# https://en.wikipedia.org/wiki/Lists_of_Columbia_Pictures_films


def connect_to_database(db_file_path):
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    return conn, cursor

def close_connection(conn):
    conn.commit()
    conn.close()

def update_films_from_csv(csv_file_path, db_file_path):
    conn, cursor = connect_to_database(db_file_path)
    film_wins = {}
    film_nominations = {}
    
    with open(csv_file_path, 'r', newline='') as csvfile:
        csv_reader = csv.DictReader(csvfile)
        for row in csv_reader:
            film_name = row['film']
            year = row['year_film']
            winner = row['winner'].lower() == 'true'
            key = (film_name, year)
            film_nominations[key] = film_nominations.get(key, 0) + 1
            if winner:
                film_wins[key] = film_wins.get(key, 0) + 1
            cursor.execute('''SELECT * FROM films WHERE title = ? AND year = ?''', (film_name, year))
            existing_film = cursor.fetchone()
            if existing_film is None:
                cursor.execute('''INSERT INTO films (title, oscars_nominated, oscars_won, year) 
                                  VALUES (?, ?, ?, ?)''', (film_name, 1, 1 if winner else 0, year))
            else:
                oscars_nominated = film_nominations[key]
                oscars_won = film_wins.get(key, 0)
                cursor.execute('''UPDATE films 
                                  SET oscars_nominated = ?, oscars_won = ?
                                  WHERE title = ? AND year = ?''', (oscars_nominated, oscars_won, film_name, year))
    close_connection(conn)

# Example usage
csv_file_path = 'the_oscar_award.csv'
db_file_path = 'films.db'
update_films_from_csv(csv_file_path, db_file_path)
