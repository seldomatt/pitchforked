require 'sqlite3'

db = SQLite3::Database.open("pitchforked.db")

sql = <<SQL
CREATE table reviews
(   id INTEGER, 
    url TEXT, 
    rating FLOAT, 
    bnm INTEGER,
    year INTEGER, 
    author TEXT, 
    body TEXT, 
    album_id INTEGER
    );
CREATE table albums
(   id INTEGER, 
    name TEXT,
    artist_id INTEGER, 
    label_id INTEGER
    );
CREATE table artists 
(   id INTEGER, 
    name TEXT
    );
CREATE table labels
(   id INTEGER, 
    name TEXT
    );
SQL

db.execute_batch( sql )