import pandas as pd
import sqlite3

db_file_path = 'database.db'
directors = [["Toy Story", {"name": "John Lasseter", "birthyear": 1957, "country": "USA"}],
             ["A Bug's Life", [
                 {"name": "John Lasseter", "birthyear": 1957, "country": "USA"},
                 {"name": "Andrew Stanton", "birthyear": 1965, "country": "USA"}
             ]],
             ["Toy Story 2", {"name": "John Lasseter",
                              "birthyear": 1957, "country": "USA"}],
             ["Monsters, Inc.", {"name": "Pete Docter",
                                 "birthyear": 1968, "country": "USA"}],
             ["Finding Nemo", {"name": "Andrew Stanton",
                               "birthyear": 1965, "country": "USA"}],
             ["The Incredibles", {"name": "Brad Bird",
                                  "birthyear": 1957, "country": "USA"}],
             ["Cars", {"name": "John Lasseter",
                       "birthyear": 1957, "country": "USA"}],
             ["Ratatouille", {"name": "Brad Bird",
                              "birthyear": 1957, "country": "USA"}],
             ["WALL-E", {"name": "Andrew Stanton",
                         "birthyear": 1965, "country": "USA"}],
             ["Kung Fu Panda", [
                 {"name": "John Stevenson", "birthyear": None, "country": None},
                 {"name": "Mark Osborne", "birthyear": None, "country": None}
             ]],
             ["Up", [
                 {"name": "Pete Docter", "birthyear": 1968, "country": "USA"},
                 {"name": "Bob Peterson", "birthyear": 1961, "country": "USA"}
             ]],
             ["Toy Story 3", {"name": "Lee Unkrich",
                              "birthyear": 1967, "country": "USA"}],
             ["Kung Fu Panda 2", {"name": "Jennifer Yuh Nelson",
                                  "birthyear": 1972, "country": "USA"}],
             ["Cars 2", [
                 {"name": "John Lasseter", "birthyear": 1957, "country": "USA"},
                 {"name": "Brad Lewis", "birthyear": None, "country": None}
             ]],
             ["Brave", [
                 {"name": "Mark Andrews", "birthyear": None, "country": None},
                 {"name": "Brenda Chapman", "birthyear": None, "country": None}
             ]],
             ["Monsters University", {"name": "Dan Scanlon",
                                      "birthyear": 1976, "country": "USA"}],
             ["The Good Dinosaur", [
                 {"name": "Peter Sohn", "birthyear": None, "country": None},
                 {"name": "Bob Peterson", "birthyear": 1961, "country": "USA"}
             ]],
             ["Inside Out", {"name": "Pete Docter",
                             "birthyear": 1968, "country": "USA"}],
             ["Kung Fu Panda 3", [
                 {"name": "Alessandro Carloni", "birthyear": None, "country": None},
                 {"name": "Jennifer Yuh Nelson", "birthyear": 1972, "country": "USA"}
             ]],
             ["Finding Dory", {"name": "Andrew Stanton",
                               "birthyear": 1965, "country": "USA"}],
             ["Coco", [
                 {"name": "Lee Unkrich", "birthyear": 1967, "country": "USA"},
                 {"name": "Adrian Molina", "birthyear": None, "country": None}
             ]],
             ["The Incredibles 2", {"name": "Brad Bird",
                                    "birthyear": 1957, "country": "USA"}],
             ["Toy Story 4", {"name": "Josh Cooley",
                              "birthyear": 1980, "country": "USA"}],
             ["Onward", {"name": "Dan Scanlon",
                         "birthyear": 1976, "country": "USA"}],
             ["Soul", [{"name": "Pete Docter", "birthyear": 1968, "country": "USA"}, {
                 "name": "Kemp Powers", "birthyear": None, "country": None}]],
             ["Lightyear", {"name": "Angus MacLane",
                            "birthyear": None, "country": None}],
             ["Kung Fu Panda 4", {"name": "Mike Mitchell",
                                  "birthyear": None, "country": None}],
             ["Snow White and the Seven Dwarfs", {
                 "name": "David Hand", "birthyear": 1900, "country": "USA"}],
             ["Cinderella", {"name": "Wilfred Jackson",
                             "birthyear": 1906, "country": "USA"}],
             ["Lady and the Tramp", {"name": "Clyde Geronimi",
                                     "birthyear": 1901, "country": "USA"}],
             ["The Jungle Book", {"name": "Wolfgang Reitherman",
                                  "birthyear": 1909, "country": "Germany"}],
             ["The Little Mermaid", {"name": "John Musker",
                                     "birthyear": 1953, "country": "USA"}],
             ["Beauty and the Beast", {"name": "Gary Trousdale",
                                       "birthyear": 1960, "country": "USA"}],
             ["Aladdin", {"name": "John Musker",
                          "birthyear": 1953, "country": "USA"}],
             ["The Lion King", {"name": "Roger Allers",
                                "birthyear": 1949, "country": "USA"}],
             ["Pocahontas", {"name": "Mike Gabriel",
                             "birthyear": 1954, "country": "USA"}],
             ["Hercules", {"name": "John Musker",
                           "birthyear": 1953, "country": "USA"}],
             ["Mulan", {"name": "Tony Bancroft",
                        "birthyear": 1967, "country": "USA"}],
             ["Tarzan", {"name": "Chris Buck",
                         "birthyear": 1958, "country": "USA"}],
             ["The Emperor's New Groove", {
                 "name": "Mark Dindal", "birthyear": 1960, "country": "USA"}],
             ["Lilo & Stitch", {"name": "Chris Sanders",
                                "birthyear": 1962, "country": "USA"}],
             ["Finding Nemo", {"name": "Andrew Stanton",
                               "birthyear": 1965, "country": "USA"}],
             ["Chicken Little", {"name": "Mark Dindal",
                                 "birthyear": 1960, "country": "USA"}],
             ["Bolt", {"name": "Byron Howard",
                       "birthyear": 1968, "country": "USA"}],
             ["Tangled", {"name": "Nathan Greno",
                          "birthyear": 1975, "country": "USA"}],
             ["Winnie the Pooh", {"name": "Don Hall",
                                  "birthyear": 1969, "country": "USA"}],
             ["Frozen", {"name": "Chris Buck",
                         "birthyear": 1958, "country": "USA"}],
             ["Big Hero 6", {"name": "Don Hall",
                             "birthyear": 1969, "country": "USA"}],
             ["Zootopia", {"name": "Byron Howard",
                           "birthyear": 1968, "country": "USA"}],
             ["Moana", {"name": "Ron Clements",
                        "birthyear": 1953, "country": "USA"}],
             ["Frozen II", {"name": "Chris Buck",
                            "birthyear": 1958, "country": "USA"}],
             ["The Lion King (2019)", {"name": "Jon Favreau",
                                       "birthyear": 1966, "country": "USA"}],
             ["Raya and the Last Dragon", {
                 "name": "Don Hall", "birthyear": 1969, "country": "USA"}],
             ["Encanto", {"name": "Byron Howard",
                          "birthyear": 1968, "country": "USA"}],
             ["Luca", {"name": "Enrico Casarosa",
                       "birthyear": 1970, "country": "Italy"}],
             ["Turning Red", {"name": "Domee Shi",
                              "birthyear": 1989, "country": "China"}]
             ]

# films, film_directors, directors, genre_films, genres, studios

def drop_tables():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    tables_to_drop = [
        'studios',
        'genres',
        'genre_films',
        'directors',
        'film_directors',
        'films'
    ]
    try:
        for table in tables_to_drop:
            cursor.execute(f"DROP TABLE IF EXISTS {table}")
            print(f"Dropped table: {table}")
    except Exception as e:
        print(f"Error while dropping tables: {e}")
    finally:
        conn.commit()
        cursor.close()
        conn.close()


def create_tables():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()

    create_studios_table_query = """
    CREATE TABLE IF NOT EXISTS studios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        year_founded INTEGER,
        headquarters TEXT
    );
    """
    create_genres_table_query = """
    CREATE TABLE IF NOT EXISTS genres (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE
    );
    """
    create_films_table_query = """
    CREATE TABLE IF NOT EXISTS films (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER,
        title TEXT,
        runtime INTEGER,
        rt_score REAL,
        imdb_score REAL,
        metacritic_score REAL,
        budget REAL,
        worldwide_gross REAL,
        domestic_gross REAL,
        international_gross REAL,
        oscars_won TEXT,
        oscars_nominated TEXT,
        overview TEXT,
        url_poster TEXT,
        studio_id INTEGER,
        FOREIGN KEY (studio_id) REFERENCES studios(id)
    );
    """
    create_genre_item_table_query = """
    CREATE TABLE IF NOT EXISTS genre_films (
        film_id INTEGER,
        genre_id INTEGER,
        PRIMARY KEY (film_id, genre_id),
        FOREIGN KEY (film_id) REFERENCES films(id),
        FOREIGN KEY (genre_id) REFERENCES genres(id)
    );
    """
    create_directors_query = """
    CREATE TABLE IF NOT EXISTS directors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        birthdate TEXT,
        country TEXT,
        UNIQUE(name)
    );
    """
    create_film_directors_table_query = """
    CREATE TABLE film_directors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        film_id INTEGER NOT NULL,
        director_id INTEGER NOT NULL,
        FOREIGN KEY (film_id) REFERENCES films(id),
        FOREIGN KEY (director_id) REFERENCES directors(id)
    );
    """
    cursor.execute(create_studios_table_query)
    cursor.execute(create_directors_query)
    cursor.execute(create_film_directors_table_query)
    cursor.execute(create_genres_table_query)
    cursor.execute(create_genre_item_table_query)
    cursor.execute(create_films_table_query)
    conn.commit()
    cursor.close()
    conn.close()


def create_studios():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    studio_data = [
        ('Disney', 1923, 'Burbank, California, USA'),
        ('Pixar', 1986, 'Emeryville, California, USA'),
        ('Marvel Studios', 1993, 'Burbank, California, USA'),
        ('DreamWorks', 1994, 'Universal City, California, USA')
    ]

    insert_query = """
    INSERT INTO studios (name, year_founded, headquarters)
    VALUES (?, ?, ?);
    """
    cursor.executemany(insert_query, studio_data)
    conn.commit()
    conn.close()


def insert_genres(genres_str, conn):
    genres_list = [genre.strip() for genre in genres_str.split(',')]
    cursor = conn.cursor()
    for genre in genres_list:
        cursor.execute("SELECT id FROM genres WHERE name = ?", (genre,))
        existing_genre = cursor.fetchone()
        if existing_genre is None:
            cursor.execute("INSERT INTO genres (name) VALUES (?)", (genre,))
            conn.commit()


def add_movies_one(path):
    df = pd.read_csv(path)
    df['studio_id'] = df.get('studio_id', default='').fillna(0).astype(int)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    cursor.execute("PRAGMA table_info(films)")
    db_columns = [row[1] for row in cursor.fetchall()]
    df_filtered = df.loc[:, df.columns.intersection(db_columns)]
    try:
        df_filtered.to_sql('films', conn, if_exists='append', index=False)
    except Exception as e:
        print(f"Error during insertion: {e}")
    finally:
        conn.commit()
        cursor.close()
        conn.close()


def add_movies(path):
    df = pd.read_csv(path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    df['title'] = df['title']
    df['studio_id'] = -1
    df['oscars_nominated'] = -1
    df['oscars_won'] = -1
    df['runtime'] = df['Runtime'].str.replace(' min', '').astype(int)
    df['worldwide_gross'] = df['Gross'].replace(
        '[\$,]', '', regex=True).astype(float)
    df['worldwide_gross'] = df['worldwide_gross'].apply(
        lambda x: round(x / 1e6, 2))
    df['year'] = df['Released_Year']
    df['imdb_score'] = df['IMDB_Rating']
    df['overview'] = df['Overview']
    df['metacritic_score'] = df['Meta_score'].round(1)
    df['url_poster'] = df['Poster_Link']
    columns_to_include = ['runtime', 'worldwide_gross', 'year',
                          'imdb_score', 'overview', 'metacritic_score', 'oscars_nominated', 'oscars_won','studio_id', 'title', 'url_poster']
    df['overview'].fillna('', inplace=True)
    df['metacritic_score'].fillna(0.0, inplace=True)
    columns_to_include = ['runtime', 'worldwide_gross', 'year',
                          'imdb_score', 'overview', 'metacritic_score', 'oscars_nominated', 'oscars_won','studio_id', 'title', 'url_poster']
    try:
        for index, row in df.iterrows():
            insert_genres(row['Genre'], conn)
            cursor.execute(
                "SELECT COUNT(*) FROM films WHERE title = ?", (row['title'],))
            movie_exists = cursor.fetchone()[0] > 0
            if not movie_exists:
                df.loc[[index], columns_to_include].to_sql(
                    'films', conn, if_exists='append', index=False)
    except Exception as e:
        print(f"Error during insertion: {e}")
    finally:
        cursor.close()
        conn.close()


def create_directors():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()

    insert_query = """
    INSERT OR IGNORE INTO directors (name, birthdate, country)
    VALUES (?, ?, ?);
    """
    for movie in directors:
        movie_title, director_info = movie
        if isinstance(director_info, list):
            for director in director_info:
                cursor.execute(
                    insert_query, (director['name'], director['birthyear'], director['country']))
        else:
            cursor.execute(
                insert_query, (director_info['name'], director_info['birthyear'], director_info['country']))

    conn.commit()
    conn.close()
    print(
        f"The Directors table has been updated in the database at '{db_file_path}'.")


def update_film_director():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()

    for film in directors:
        film_title, director_info = film
        cursor.execute("SELECT id FROM films WHERE title = ?", (film_title,))
        film_id = cursor.fetchone()
        if not film_id:
            continue
        film_id = film_id[0]
        if isinstance(director_info, list):
            directors_list = director_info
        else:
            directors_list = [director_info]

        for director in directors_list:
            cursor.execute(
                "SELECT id FROM directors WHERE name = ?", (director['name'],))
            director_id = cursor.fetchone()
            if director_id:
                director_id = director_id[0]
                cursor.execute(
                    "INSERT OR IGNORE INTO film_directors (film_id, director_id) VALUES (?, ?)", (film_id, director_id))
    conn.commit()
    conn.close()
    print(
        f"The MovieDirectors table has been updated with the corresponding movie-director relationships in the database at '{db_file_path}'.")


def update_film_director_two(film_path, films_csv_path):
    df_films_csv = pd.read_csv(films_csv_path)
    df_films = pd.read_csv(film_path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    film_id_dict = {row['title']: row['id']
                    for _, row in df_films_csv.iterrows()}
    for _, film in df_films.iterrows():
        film_title = film['title']
        director_name = film['Director']
        film_id = film_id_dict.get(film_title)
        if film_id is None:
            continue
        cursor.execute(
            "SELECT id FROM directors WHERE name = ?", (director_name,))
        director_id_row = cursor.fetchone()
        if director_id_row is None:
            continue
        director_id = director_id_row[0]
        cursor.execute('''
            INSERT INTO film_directors (film_id, director_id)
            VALUES (?, ?)
        ''', (film_id, director_id))
    conn.commit()
    cursor.close()
    conn.close()

    print(
        f"The film_directors table has been updated with the corresponding movie-director relationships in the database at '{db_file_path}'.")


def create_genre_items(genres_path, films_path):
    df_genres = pd.read_csv(genres_path)
    df_films = pd.read_csv(films_path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    df_merged = pd.merge(df_genres, df_films, on='title', how='inner')
    for _, row in df_merged.iterrows():
        film_id = row['id']
        genres_str = row['Genre']
        genres_list = [genre.strip() for genre in genres_str.split(',')]
        for genre in genres_list:
            cursor.execute("SELECT id FROM genres WHERE name = ?", (genre,))
            genre_id_row = cursor.fetchone()
            if genre_id_row:
                genre_id = genre_id_row[0]
                cursor.execute('''
                    INSERT OR IGNORE INTO genre_films (film_id, genre_id)
                    VALUES (?, ?)
                ''', (film_id, genre_id))
    conn.commit()
    cursor.close()
    conn.close()


def create_film_director(films_path, directors_path):
    df_films = pd.read_csv(films_path)
    df_directors = pd.read_csv(directors_path)
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    directors_dict = {row['name']: (row['id'], row.get('birthdate'), row.get('country'))
                      for _, row in df_directors.iterrows()}
    for _, film in df_films.iterrows():
        director_name = film['Director']
        cursor.execute(
            "SELECT id, birthdate, country FROM directors WHERE name = ?", (director_name,))
        existing_director = cursor.fetchone()

        if existing_director:
            continue
        director_info = directors_dict.get(director_name)
        if director_info:
            cursor.execute(
                "INSERT INTO directors (name, birthdate, country) VALUES (?, ?, ?)",
                (director_name, director_info[1], director_info[2])
            )
        else:
            cursor.execute(
                "INSERT INTO directors (name, birthdate, country) VALUES (?, NULL, NULL)",
                (director_name,)
            )
    conn.commit()
    cursor.close()
    conn.close()


def export_tables_to_csv(output_dir):
    conn = sqlite3.connect(db_file_path)
    tables = ['studios', 'directors', 'film_directors',
              'films', 'genres', 'genre_films']
    for table in tables:
        query = f"SELECT * FROM {table};"
        df = pd.read_sql(query, conn)
        csv_file_path = f"{output_dir}/{table}.csv"
        df.to_csv(csv_file_path, index=False)
    print(
        f"Tables have been exported to '{csv_file_path}' as separate sheets.")


def update_studio_id(path):
    df = pd.read_csv(path)
    columns = list(df.columns)
    studio_id_index = columns.index('studio_id')
    new_position = max(0, studio_id_index - 2)
    columns.pop(studio_id_index)
    columns.insert(new_position, 'studio_id')
    df = df[columns]
    df.to_csv(path, index=False)
    return df

drop_tables()
create_tables()
create_studios()
add_movies_one('./movies_one.csv')
create_directors()
update_film_director()

add_movies('./imdb_top_1000.csv')
create_genre_items('./imdb_top_1000.csv', './films.csv')
create_film_director('./imdb_top_1000.csv', './directors.csv')
update_film_director_two('./imdb_top_1000.csv', './films.csv')
export_tables_to_csv('.')
update_studio_id('./films.csv')
