import sqlite3
from faker import Faker
from datetime import datetime, timedelta
import random


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


def select_random_job_and_department():
    department = random.choice(list(department_map.keys()))
    job_title = random.choice(department_map[department])
    department_id = get_department_id_from_database(department)

    return job_title, department_id


def get_department_id_from_database(department):
    department_id = department_ids.get(department)
    return department_id
