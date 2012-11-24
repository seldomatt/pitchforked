require 'sqlite3'

db = SQLite3::Database.open("refactored.db")

sql = <<SQL
CREATE table reviews
(   id INTEGER PRIMARY KEY, 
    url TEXT, 
    rating FLOAT, 
    bnm INTEGER,
    year INTEGER, 
    author TEXT, 
    body TEXT, 
    album_id INTEGER
    );
CREATE table albums
(   id INTEGER PRIMARY KEY, 
    name TEXT,
    artist_id INTEGER, 
    label_id INTEGER
    );
CREATE table artists 
(   id INTEGER PRIMARY KEY, 
    name TEXT
    );
CREATE table labels
(   id INTEGER PRIMARY KEY, 
    name TEXT
    );
SQL

db.execute_batch( sql )