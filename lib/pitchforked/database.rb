require 'sqlite3'

class Database 

  attr_accessor :db

  def initialize(database)
    @db = SQLite3::Database.open(database)
    @db.results_as_hash = true
  end

  def insert_record(table,columns, vals)
    self.db.execute("INSERT INTO #{table} (#{columns.join(",")}) VALUES (#{self.get_placeholders(columns)})", vals)
  end

  def select_record_by_attr(table, attribute, match)
    self.db.execute("SELECT * FROM #{table} WHERE #{attribute} = '#{match}'").first
  end

  def get_placeholders(columns)
    Array.new(columns.length, "?").join(",")
  end

end