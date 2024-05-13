import pandas as pd
import sqlite3

db_file_path = './database.db'

def create_studio_table():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_table_query = """
    CREATE TABLE IF NOT EXISTS studios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        "founded year" INTEGER,
        headquarters TEXT
    );
    """
    cursor.execute(create_table_query)
    studio_data = [
        ('Disney', 1923, 'Burbank, California, USA'),
        ('Pixar', 1986, 'Emeryville, California, USA'),
        ('Marvel Studios', 1993, 'Burbank, California, USA')
    ]

    insert_query = """
    INSERT INTO studios (name, "founded year", headquarters)
    VALUES (?, ?, ?);
    """
    cursor.executemany(insert_query, studio_data)
    conn.commit()
    conn.close()
    print(
        f"The Studio table has been created and populated with Disney, Pixar, and Marvel Studios data in the database at '{db_file_path}'.")

def create_directors(db_file_path, directors):
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_table_query = """
    CREATE TABLE IF NOT EXISTS directors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        birthdate TEXT,
        country TEXT,
        UNIQUE(name)
    );
    """
    cursor.execute(create_table_query)
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

    # Commit the changes and close the connection
    conn.commit()
    conn.close()
    print(
        f"The Directors table has been updated in the database at '{db_file_path}'.")

# Define the path to your SQLite database file
db_file_path = 'path_to_your_database_file.db'

def add_movies(path):
    df = pd.read_csv(path)
    df['length'] = df['length'].round(0)
    df['rt_score'] = df['rt_score'].round(1)
    df['imdb_score'] = df['imdb_score'].round(1)
    df['metacritic_score'] = df['metacritic_score'].round(1)
    df['opening_weekend'] = df['opening_weekend'].round(2)
    df['worldwide_gross'] = df['worldwide_gross'].round(2)
    df['domestic_gross'] = df['domestic_gross'].round(2)
    df['adjusted_domestic_gross'] = df['adjusted_domestic_gross'].round(2)
    df['international_gross'] = df['international_gross'].round(2)
    df['domestic_percent'] = df['domestic_percent'].round(2)
    df['international_percent'] = df['international_percent'].round(2)
    df['production_budget'] = df['production_budget'].round(2)
    conn = sqlite3.connect(db_file_path)
    df.to_sql('movies', conn, if_exists='append', index=False)
    conn.close()

def update_gross_percentages(csv_file_path, output_file_path):
    df = pd.read_csv(csv_file_path)
    df['Domestic Gross'] = pd.to_numeric(df['Domestic Gross'], errors='coerce')
    df['Worldwide Gross'] = pd.to_numeric(
        df['Worldwide Gross'], errors='coerce')
    df['International Gross'] = pd.to_numeric(
        df['International Gross'], errors='coerce')
    df['Domestic Gross'].fillna(0, inplace=True)
    df['International Gross'].fillna(0, inplace=True)
    df['Domestic %'] = round(
        (df['Domestic Gross'] / df['Worldwide Gross']) * 100, 2)
    df['International %'] = round(
        (df['International Gross'] / df['Worldwide Gross']) * 100, 2)
    df['Oscars Nominated'].fillna(0, inplace=True)
    df['Oscars Won'].fillna(0, inplace=True)
    df['Oscars Nominated'] = df['Oscars Nominated'].astype(int)
    df['Oscars Won'] = df['Oscars Won'].astype(int)
    df.to_csv(output_file_path, index=False)
    print(f"Updated data has been saved to '{output_file_path}'.")

# update_gross_percentages('./Pixar.csv','./Pixar2.csv')
# update_gross_percentages('./Disney.csv','./Disney2.csv')

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

def assign_movie_ids(db_file_path):
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_new_table_query = """
    CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        length INTEGER,
        rt_score REAL,
        imdb_score REAL,
        metacritic_score REAL,
        opening_weekend REAL,
        worldwide_gross REAL,
        domestic_gross REAL,
        adjusted_domestic_gross REAL,
        international_gross REAL,
        domestic_percent REAL,
        international_percent REAL,
        production_budget REAL,
        oscars_nominated INTEGER,
        oscars_won INTEGER,
        studio_id INTEGER,
        FOREIGN KEY (studio_id) REFERENCES studios(id)
    );
    """
    cursor.execute(create_new_table_query)
    copy_data_query = """
    INSERT INTO movies_new (
        title, length, rt_score, imdb_score, metacritic_score, opening_weekend,
        worldwide_gross, domestic_gross, adjusted_domestic_gross,
        international_gross, domestic_percent, international_percent,
        production_budget, oscars_nominated, oscars_won, studio_id
    )
    SELECT title, length, "RT Score", "IMDB Score", "Metacritic Score", "Opening Weekend",
           "Worldwide Gross", "Domestic Gross", "Adjusted Domestic Gross",
           "International Gross", "Domestic %", "International %",
           "Production Budget", "Oscars Nominated", "Oscars Won", "Studio Id"
    FROM movies;
    """
    cursor.execute(copy_data_query)
    cursor.execute("DROP TABLE movies;")
    cursor.execute("ALTER TABLE movies_new RENAME TO movies;")
    conn.commit()
    conn.close()
    print(f"The 'movies' table has been updated with an 'id' column as a primary key in the database at '{db_file_path}'.")

def update_movies_directors(db_file_path, directors):
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_table_query = """
    CREATE TABLE movie_directors (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        movie_id INTEGER NOT NULL,
        director_id INTEGER NOT NULL,
        FOREIGN KEY (movie_id) REFERENCES movies(id),
        FOREIGN KEY (director_id) REFERENCES directors(id)
    );
    """
    # Execute the query to create the Directors table
    cursor.execute(create_table_query)

    for movie in directors:
        movie_title, director_info = movie
        cursor.execute("SELECT id FROM movies WHERE title = ?", (movie_title,))
        movie_id = cursor.fetchone()
        if not movie_id:
            continue
        movie_id = movie_id[0]
        if isinstance(director_info, list):
            directors_list = director_info
        else:
            directors_list = [director_info]

        for director in directors_list:
            cursor.execute("SELECT id FROM directors WHERE name = ?", (director['name'],))
            director_id = cursor.fetchone()
            if director_id:
                director_id = director_id[0]
                cursor.execute("INSERT OR IGNORE INTO movie_directors (movie_id, director_id) VALUES (?, ?)", (movie_id, director_id))
    conn.commit()
    conn.close()
    print(f"The MovieDirectors table has been updated with the corresponding movie-director relationships in the database at '{db_file_path}'.")

# assign_movie_ids(db_file_path)

def export_tables_to_csv(db_file_path, output_dir):
    conn = sqlite3.connect(db_file_path)
    tables = ['movies', 'directors', 'studios', 'movie_directors']
    for table in tables:
        query = f"SELECT * FROM {table};"
        df = pd.read_sql(query, conn)
        csv_file_path = f"{output_dir}/{table}.csv"
        df.to_csv(csv_file_path, index=False)
    print(f"Tables have been exported to '{csv_file_path}' as separate sheets.")

db_file_path = './database.db'
csv_file_path = '.'

def create_movies_table():
    conn = sqlite3.connect(db_file_path)
    cursor = conn.cursor()
    create_new_table_query = """
    CREATE TABLE movies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER,
        title TEXT,
        length INTEGER,
        rt_score REAL,
        imdb_score REAL,
        metacritic_score REAL,
        opening_weekend REAL,
        worldwide_gross REAL,
        domestic_gross REAL,
        adjusted_domestic_gross REAL,
        international_gross REAL,
        domestic_percent REAL,
        international_percent REAL,
        production_budget REAL,
        oscars_nominated INTEGER,
        oscars_won INTEGER,
        studio_id INTEGER,
        FOREIGN KEY (studio_id) REFERENCES studios(id)
    );
    """
    cursor.execute(create_new_table_query)

create_movies_table()
add_movies('./movies.csv')
# create_studio_table()
# update_movies_directors(db_file_path, directors)
# create_directors(db_file_path, directors)
export_tables_to_csv(db_file_path, csv_file_path)
