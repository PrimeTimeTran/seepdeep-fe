import sqlite3
from faker import Faker
from datetime import datetime, timedelta
import random

conn = sqlite3.connect('chinook.db')
cursor = conn.cursor()
fake = Faker()
cursor.execute("SELECT employee_id FROM employees")
employee_ids = cursor.fetchall()

for employee_id in employee_ids:
    address_parts = fake.address().split('\n')
    address = address_parts[0]
    city_state_zip = address_parts[-1]
    while ',' not in city_state_zip:
        address_parts = fake.address().split('\n')
        address = address_parts[0]
        city_state_zip = address_parts[-1]
    city, state_zip = city_state_zip.split(', ')
    state, zip = state_zip.split(' ')
    area_code = fake.random_int(100, 999)
    first_three = fake.random_int(100, 999)
    last_four = fake.random_int(1000, 9999)
    extension = fake.random_int(1000, 99999)
    phone = f"({area_code}){first_three}-{last_four}x{extension}"
    random_days = random.randint(0, 21 * 365)
    start_date = datetime.now() - timedelta(days=21 * 365)
    random_date = start_date + timedelta(days=random_days)
    cursor.execute("UPDATE employees SET address = ?, city = ?, state = ?, postal_code = ?, country = ?, phone = ?, hire_date = ? WHERE employee_id = ?", (address, city, state, zip, "USA", phone, random_date.date(), employee_id[0]))

conn.commit()
conn.close()

print("Addresses updated successfully.")
