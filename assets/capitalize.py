import sqlite3

conn = sqlite3.connect('database.db')
cursor = conn.cursor()

def capitalize_name(name):
    return ' '.join(word.capitalize() for word in name.split())
cursor.execute('SELECT ROWID, name FROM directors')
directors = cursor.fetchall()
for rowid, name in directors:
    capitalized_name = capitalize_name(name)
    cursor.execute('UPDATE directors SET name = ? WHERE ROWID = ?', (capitalized_name, rowid))

conn.commit()
conn.close()
