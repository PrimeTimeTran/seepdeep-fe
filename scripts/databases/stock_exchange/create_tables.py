import sqlite3

conn = sqlite3.connect('stocks.db')
cur = conn.cursor()


def drop_tables():
    cur.execute('DROP TABLE IF EXISTS Exchanges;')
    cur.execute('DROP TABLE IF EXISTS Companies;')
    cur.execute('DROP TABLE IF EXISTS Assets;')
    cur.execute('DROP TABLE IF EXISTS AssetPrices;')
    cur.execute('DROP TABLE IF EXISTS Orders;')
    cur.execute('DROP TABLE IF EXISTS OrderBooks;')
    cur.execute('DROP TABLE IF EXISTS Users;')
    cur.execute('DROP TABLE IF EXISTS Accounts;')
    cur.execute('DROP TABLE IF EXISTS Transfers;')


def create_tables():
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Exchanges (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT,
          founded TEXT,
          market_cap REAL,
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Companies (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          ceo TEXT,
          description TEXT,
          hq TEXT,
          founded TEXT,
          url_favicon TEXT,
          url_webpage TEXT,
          market_cap REAL,
          country TEXT,
          sector TEXT
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Assets (
          id INTEGER PRIMARY KEY AUTOINCREMENT,

          sym TEXT NOT NULL,
          exchange_id INTEGER,
          name TEXT NOT NULL,
          mc TEXT NOT NOT NULL,
          industry TEXT NOT NULL,
          type TEXT NOT NULL,
          status TEXT NOT NULL,
          url_icon TEXT,

          volume INTEGER NOT NULL,
          price_open REAL NOT NULL,
          day_hi REAL NOT NULL,
          day_lo REAL NOT NULL,
          price_close REAL NOT NULL,

          year_hi REAL NOT NULL,
          year_lo REAL NOT NULL,

          change_1_day REAL NOT NULL,
          change_1_week REAL NOT NULL,
          change_1_month REAL NOT NULL,
          change_3_month REAL NOT NULL,
          change_6_month REAL NOT NULL,
          change_1_year REAL NOT NULL,
          change_3_year REAL NOT NULL,
          change_5_year REAL NOT NULL,
          change_10_year REAL NOT NULL,

          change_year_hi TEXT NOT NULL,
          change_year_lo TEXT NOT NULL,

          revenue TEXT NOT NULL,
          revenue_growth_yoy REAL NOT NULL,
          revenue_growth_5y REAL NOT NULL,
          earnings TEXT NOT NULL,
          earnings_growth_yoy REAL NOT NULL,
          revenue_growth_5y REAL NOT NULL,
          ebitda REAL,
          eps REAL NOT NULL,
          pe REAL,
          de REAL NOT NULL,
          po_ratio REAL,
          dy REAL NOT NULL,
          price  REAL NOT NULL,
          average_volume INTEGER,
          div_last TEXT NOT NULL,
          div_annual REAL NOT NULL,
          div_percent REAL NOT NULL,
          div_dropped INTEGER NOT NULL,
          shares INTEGER NOT NULL,
          ex_div_date TEXT NOT NULL,
          div_payment_date TEXT NOT NULL,
          country TEXT NOT NULL,
          institutional REAL NOT NULL,
          insider REAL NOT NULL,
          FOREIGN KEY (company_id) REFERENCES Companies(id)
          FOREIGN KEY (exchange_id) REFERENCES Exchange(id)
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS AssetPrices (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          asset_id INTEGER NOT NULL,
          timestamp DATETIME,
          source TEXT,
          volume INTEGER,
          price_open REAL,
          price_hi REAL,
          price_lo REAL,
          price_close REAL,
          FOREIGN KEY (asset_id) REFERENCES Assets(id)
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Orders (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          asset_id INTEGER,
          asset_type TEXT,
          price_asset REAL,
          amount REAL,
          quantity REAL,
          status TEXT,
          strike REAL,
          price_limit REAL,
          price_stop REAL,
          expires DATETIME,
          order_type TEXT,
          buy_in TEXT,
          trail_type TEXT,
          trail_percentage REAL,
          trail_amount REAL,
          FOREIGN KEY (user_id) REFERENCES Users(id),
          FOREIGN KEY (asset_id) REFERENCES Assets(id)
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS OrderBooks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          sym TEXT NOT NULL,
          current_bid_price REAL,
          current_ask_price REAL,
          current_bid_quantity REAL,
          current_ask_quantity REAL,
          last_update DATETIME,
          bids TEXT,
          asks TEXT
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT NOT NULL UNIQUE,
          pw_digest TEXT,
          first_name TEXT,
          last_name TEXT,
          phone TEXT
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Accounts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          number TEXT NOT NULL,
          routing TEXT,
          institution TEXT,
          value REAL,
          type TEXT,
          name TEXT,
          nickname TEXT,
          FOREIGN KEY (user_id) REFERENCES Users(id)
      )
  ''')
    cur.execute('''
      CREATE TABLE IF NOT EXISTS Transfers (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER,
          account_id INTEGER,
          value REAL,
          type TEXT,
          status TEXT,
          FOREIGN KEY (user_id) REFERENCES Users(id),
          FOREIGN KEY (account_id) REFERENCES Accounts(id)
      )
  ''')


drop_tables()
create_tables()


conn.commit()
conn.close()
