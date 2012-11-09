require 'sqlite3'

class Database 

  attr_accessor :db

  def initialize(database)
    @db = SQLite3::Database.open(database)
    @db.results_as_hash = true
  end

  def insert_record(table,columns,placeholders,vals)
    self.db.execute("INSERT INTO #{table} (#{columns}) VALUES (#{placeholders})", vals)
  end

  def select_record_by_attr(table, attribute, match)
    self.db.execute("SELECT * FROM #{table} WHERE #{attribute} = '#{match}'").first
  end

end