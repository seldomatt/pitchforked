require_relative 'database'

module ActiveWreckord
  require 'sqlite3'

  module InstanceMethods

    def save
      db = self.class.open_db_connection
      columns = self.get_columns 
      vals = self.get_vals
      db.insert_record("#{self.class.table}", columns, vals)
    end

    def get_columns 
      self.instance_variables.map{|ivar| ivar.to_s.delete("@")}
    end

    def get_vals
      self.instance_variables.map {|ivar| self.send(ivar.to_s.delete("@"))}
    end


  end

  module ClassMethods

    def find(id)
      db = self.open_db_connection
      result = db.select_record_by_attr("#{self.table}", "id", "#{id}")
      self.object_from_db(result) if result != nil
    end

    def object_from_db(query_result_hash)
      object = self.new
      query_result_hash.each do |k,v|
        unless (k.is_a?(Fixnum))
          object.send("#{k}=", v)
        end
      end
      object
    end

    def create_unique(name)
      self.find_by_name(name) || self.new.tap{|object| object.name = name}
    end

    def find_by_name(name)
      db = self.open_db_connection
      result = db.select_record_by_attr("#{self.table}", "name", "#{name}")
      self.object_from_db(result) if result != nil
    end

    def table
      self.to_s.downcase.concat("s")
    end
 

    def open_db_connection
      Database.new('pitchforked.db')
    end

  end

end