import sqlite3
from faker import Faker
from datetime import datetime, timedelta
import random


# Jira?
# Employees
# Departments
# Customers
# Projects
# Tickets
# Invoices

conn = sqlite3.connect('database.db')
cursor = conn.cursor()
fake = Faker()

department_ids = {
    "Development": 1,
    "Product": 2,
    "Business Development": 3,
    "HR": 4,
    "Finance": 5,
    "Marketing": 6,
    "Customer Support": 7,
    "Design": 8,
    "Accounting": 9,
    "System Admin": 10,
}

department_map = {
    'Development': ['Product Engineer',
                    'Frontend Developer',
                    'Backend Developer',
                    'Full Stack Developer',
                    'QA Engineer',],
    'Design': ['UI/UX Designer',
               'Graphic Designer',
               'Visual Designer',
               'Product Designer',],
    'Product': ['Product Owner',
                'Product Lead',
                'Technical Product Manager',
                'Project Manager',],
    'Business Development': ['Sales Manager',
                             'Business Development',
                             'Account Executive',
                             'Sales Manager',
                             'Sales Executive',
                             'Sales Director',
                             'Partnership Manager',
                             'Client Relations Manager',],
    'Marketing': ['Marketing Coordinator',
                  'Marketing Assistant',
                  'Marketing Associate',
                  'Social Media Coordinator',
                  'Content Marketing Specialist',
                  'Digital Marketing Specialist',
                  'Social Media Manager'],
    'System Admin': ['Database Admin',],
    'Accounting': ['Accountant',
                   'Controller',
                   'Auditor',
                   'Financial Analyst'],
    'HR': ['HR Manager',
           'HR Coordinator',
           'HR Generalist',
           'Benefits Administrator',
           'Talent Acquisition Specialist',
           'Recruiter',
           'Employee Relations Manager',],
}

states = ["FL", "CA", 'NY']

departments = ['Development', 'Product', 'Business Development', 'Human Resources',
               'Finance', 'Marketing', 'Customer Support', 'Design', 'Accounting', 'System Admin']
men = ['Tim', 'Michael', 'Daniel', 'Charles',
       'Peter', 'Ben', 'Binh', 'Mark', 'Adam', 'Casey']
women = ['Ada', 'Ava', 'Emma', 'Mia', 'Isabella', 'Olivia', 'Rose', 'Rachel', 'Helen', 'Uyen', 'Thanh', 'Thuy', 'Ngoc',
         'Linh', 'Trang', 'Hien', 'Tram', 'Nguyet', 'Diep', 'Nguyen', 'Hanh', 'Dieu', 'Chau']
surnames = ['Bui', 'Nguyen', 'Tran', 'Duong', 'Dang', 'Ngo', 'Ho', 'Pham', 'Huynh', 'Phan', 'Ly', 'Do', 'Le',
            'Cong', 'Wilson', 'Jones', 'Smith', 'Williams', 'Wilson', 'Anderson', 'Brown', 'Johnson', 'Garcia', 'Miller']

def select_random_job_and_department():
    department = random.choice(list(department_map.keys()))
    job_title = random.choice(department_map[department])
    department_id = get_department_id_from_database(department)

    return job_title, department_id


def get_department_id_from_database(department):
    department_id = department_ids.get(department)
    return department_id


def update_ids():
    cursor.execute("""
        -- Create a temporary table to store the updated id values
        CREATE TEMP TABLE temp_employees AS
        SELECT
            id,
            ROW_NUMBER() OVER (ORDER BY id) AS new_id
        FROM
            employees;
        """)
    cursor.execute("""
        -- Update the original employees table with the new id values
        UPDATE employees
        SET id = (
            SELECT new_id
            FROM temp_employees
            WHERE temp_employees.id = employees.id
        );
        """)
    cursor.execute("""
        -- Drop the temporary table
        DROP TABLE temp_employees;
    """)


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


conn.commit()
conn.close()
