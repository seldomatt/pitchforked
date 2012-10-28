require_relative 'album'

class Review 
  include Unique
  attr_accessor :id, :url, :rating, :year, :author, :body, :album_id

  def initialize
    self.class.all << self
  end

  def self.all
    @@reviews ||= []
  end

  def find_album
    Album.all.select {|a| a.id == self.album_id }.first
  end


end