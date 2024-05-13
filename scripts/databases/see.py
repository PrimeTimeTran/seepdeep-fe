import csv
import sqlite3

def connect_to_database(db_file_path):
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    return conn, cursor

def close_connection(conn):
    conn.commit()
    conn.close()

def update_films_from_csv(csv_file_path, db_file_path):
    conn, cursor = connect_to_database(db_file_path)
    
    # Dictionaries to keep track of nomination counts and wins for each film
    film_nominations = {}
    film_wins = {}
    
    with open(csv_file_path, 'r', newline='') as csvfile:
        csv_reader = csv.DictReader(csvfile)
        for row in csv_reader:
            film_name = row['film']
            year = row['year_film']
            winner = row['winner'].lower() == 'true'
            
            # Increment nomination count for the film
            key = (film_name, year)
            film_nominations[key] = film_nominations.get(key, 0) + 1
            
            # If the film won, increment its win count
            if winner:
                film_wins[key] = film_wins.get(key, 0) + 1
            
            cursor.execute('''SELECT * FROM films WHERE title = ? AND year = ?''', (film_name, year))
            existing_film = cursor.fetchone()
            if existing_film is None:
                # If the film doesn't exist, create it with initial values
                cursor.execute('''INSERT INTO films (title, oscars_nominated, oscars_won, year) 
                                  VALUES (?, ?, ?, ?)''', (film_name, 1, 1 if winner else 0, year))
            else:
                # If the film exists, update its nominated and won count accordingly
                oscars_nominated = film_nominations[key]
                oscars_won = film_wins.get(key, 0)  # Get the number of wins from the map
                cursor.execute('''UPDATE films 
                                  SET oscars_nominated = ?, oscars_won = ?
                                  WHERE title = ? AND year = ?''', (oscars_nominated, oscars_won, film_name, year))
    
    close_connection(conn)

# Example usage
csv_file_path = 'the_oscar_award.csv'
db_file_path = 'films.db'
update_films_from_csv(csv_file_path, db_file_path)
