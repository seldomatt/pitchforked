require_relative 'album'

class Review 
  extend Unique
  include PrimKey
  include ActiveWreckord::InstanceMethods
  extend ActiveWreckord::ClassMethods
  attr_accessor :id, :url, :rating, :bnm, :year, :author, :body, :album_id

  def self.table 
    "reviews"
  end

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