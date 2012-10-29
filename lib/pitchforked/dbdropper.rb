require 'sqlite3'

db = SQLite3::Database.open("pitchforked.db")

sql = <<SQL
DROP table reviews;
DROP table albums;
DROP table artists;
DROP table labels;
SQL

db.execute_batch( sql )