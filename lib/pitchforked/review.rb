require_relative 'album'

class Review 
  attr_accessor :id, :url, :rating, :year, :author, :body, :album_id

  def initialize
    self.class.all << self
  end

  def self.all
    @@reviews ||= []
  end

  def find_album
    Album.all.detect {|a| a.id == self.album_id }
  end


end