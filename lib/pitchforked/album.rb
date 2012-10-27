
class Album 
  attr_accessor :id, :name, :artist_id, :label_id

  def initialize
    self.class.all << self
  end


  def self.all
    @@albums ||= []
  end

end