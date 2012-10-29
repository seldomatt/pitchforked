
class Album 
  extend Unique
  include PrimKey
  include ActiveWreckord
  attr_accessor :id, :name, :artist_id, :label_id

  def self.table
    "albums"
  end

  def initialize
    self.class.all << self
  end


  def self.all
    @@albums ||= []
  end

end