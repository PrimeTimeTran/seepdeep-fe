import sqlite3
from faker import Faker
from datetime import datetime, timedelta
import random

from seed_helpers import create_employee, update_ids

conn = sqlite3.connect('database.db')
cursor = conn.cursor()
fake = Faker()

def create_250_employees():
  for i in range(1, 250):
    create_employee()
    update_ids()

