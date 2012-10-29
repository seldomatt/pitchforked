module ActiveWreckord
  require 'sqlite3'

  def save
    table = self.class.table
    attr_cols = self.instance_variables.map{|ivar| ivar.to_s.delete("@").join(", ")}
    placeholders =  String.new.tap{|s| self.instance_variables.count.times do s << "?, " end}.chomp(", ")
    vals = self.instance_variables.map {|ivar| self.send(ivar.to_s.delete("@"))}
    @db.execute("INSERT INTO #{table} (#{attr_cols}) VALUES (?,?)", vals)
  end




end