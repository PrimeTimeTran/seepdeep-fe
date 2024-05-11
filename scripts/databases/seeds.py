import sqlite3
from faker import Faker
from datetime import datetime, timedelta
import random

from seed_helpers import select_random_job_and_department

conn = sqlite3.connect('chinook.db')
cursor = conn.cursor()
fake = Faker()
cursor.execute("SELECT employee_id FROM employees")
employee_ids = cursor.fetchall()

# Jira?
# Employees
# Departments
# Customers
# Projects
# Tickets
# Invoices

states = ["FL", "CA", 'NY']

departments = ['Development', 'Product', 'Business Development', 'Human Resources',
               'Finance', 'Marketing', 'Customer Support', 'Design', 'Accounting', 'System Admin']
men = ['Tim', 'Michael', 'Daniel', 'Charles',
       'Peter', 'Ben', 'Binh', 'Mark', 'Adam', 'Casey']
women = ['Ada', 'Ava', 'Emma', 'Mia', 'Isabella', 'Olivia', 'Rose', 'Rachel', 'Helen', 'Uyen', 'Thanh', 'Thuy', 'Ngoc',
         'Linh', 'Trang', 'Hien', 'Tram', 'Nguyet', 'Diep', 'Nguyen', 'Hanh', 'Dieu', 'Chau']
surnames = ['Bui', 'Nguyen', 'Tran', 'Duong', 'Dang', 'Ngo', 'Ho', 'Pham', 'Huynh', 'Phan', 'Ly', 'Do', 'Le',
            'Cong', 'Wilson', 'Jones', 'Smith', 'Williams', 'Wilson', 'Anderson', 'Brown', 'Johnson', 'Garcia', 'Miller']


def create_employee():
    gender = random.randint(0, 1)
    if gender == 0:
        name = random.sample(men, 1)[0]
    else:
        name = random.sample(women, 1)[0]
    surname = random.sample(surnames, 1)[0]
    sex = "m" if gender == 0 else "f"

    address_parts = fake.address().split('\n')
    address = address_parts[0]
    city_state_zip = address_parts[-1]
    while ',' not in city_state_zip:
        address_parts = fake.address().split('\n')
        address = address_parts[0]
        city_state_zip = address_parts[-1]
    city, state_zip = city_state_zip.split(', ')
    state, postal_code = state_zip.split(' ')
    state = random.sample(states, 1)[0]
    area_code = fake.random_int(100, 999)
    first_three = fake.random_int(100, 999)
    last_four = fake.random_int(1000, 9999)
    phone = f"({area_code}) {first_three}-{last_four}"
    random_days = random.randint(0, 21 * 365)
    start_date = datetime.now() - timedelta(days=21 * 365)
    birth_date = start_date + timedelta(days=random_days)
    age = (datetime.now() - birth_date).days // 365
    end_date = datetime.now()
    start_date = end_date - timedelta(days=21 * 365)
    random_days = random.randint(0, (end_date - start_date).days)
    hire_date = start_date + timedelta(days=random_days)
    base_salary = 75000
    increments = random.randint(0, 10)
    salary = base_salary + (increments * 5000)
    job_title, department_id = select_random_job_and_department()
    email = name + '.' + surname + '@seepdeep.com'
    cursor.execute("""
    INSERT INTO employees (   
                name, 
                surname, 
                salary, 
                address, 
                city, 
                state, 
                postal_code, 
                country,
                phone, 
                birth_date, 
                hire_date,
                title, 
                department_id, 
                sex, 
                email,
                age
                )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)
    """, (
        name,
        surname,
        salary,
        address,
        city,
        state,
        postal_code,
        "US",
        phone,
        birth_date.date(),
        hire_date.date(),
        job_title,
        department_id,
        sex,
        email,
        age
    ))


def update_ids():
    cursor.execute("""
        -- Create a temporary table to store the updated employee_id values
        CREATE TEMP TABLE temp_employees AS
        SELECT
            employee_id,
            ROW_NUMBER() OVER (ORDER BY employee_id) AS new_employee_id
        FROM
            employees;
        """)
    cursor.execute("""
        -- Update the original employees table with the new employee_id values
        UPDATE employees
        SET employee_id = (
            SELECT new_employee_id
            FROM temp_employees
            WHERE temp_employees.employee_id = employees.employee_id
        );
        """)
    cursor.execute("""
        -- Drop the temporary table
        DROP TABLE temp_employees;
    """)

for i in range(1, 250):
    create_employee()
    update_ids()

def update_employees():
    print('hi')

conn.commit()
conn.close()

print("Addresses updated successfully.")
