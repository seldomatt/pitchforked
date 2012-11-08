module ActiveWreckord
  require 'sqlite3'

  module InstanceMethods

    def save
      db, table = self.class.open_db_connection
      attr_cols = self.instance_variables.map{|ivar| ivar.to_s.delete("@")}.join(", ")
      placeholders =  String.new.tap{|s| self.instance_variables.count.times do s << "?, " end}.chomp(", ")
      vals = self.instance_variables.map {|ivar| self.send(ivar.to_s.delete("@"))}
      db.execute("INSERT INTO #{table} (#{attr_cols}) VALUES (#{placeholders})", vals)
    end

  end

  module ClassMethods

    def find(id)
      object = self.new
      db, table = self.open_db_connection
      result = db.execute("SELECT * FROM #{table} WHERE id = '#{id}'").first
      if result != nil
        result.each do |k,v|
          if !(k.is_a?(Fixnum))
            object.send("#{k}=".to_sym, v)
          end
        end
      object
      end
    end

    def create_unique(name)
      result = self.find_by_name(name)
      if result == nil
        new_object = self.new.tap{|object| object.name = name}
      else
        self.find(result["id"])
      end
    end

    def find_by_name(name)
      db, table = self.open_db_connection
      db.execute("SELECT * FROM #{table} WHERE name = '#{name}'").first
    end

    def table
      self.to_s.downcase.concat("s")
    end
 

    def open_db_connection
      db = SQLite3::Database.open('pitchforked.db')
      db.results_as_hash = true
      table = self.table
      return db, table
    end

  end

end