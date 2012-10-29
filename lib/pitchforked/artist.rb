require_relative 'album'

class Artist 
  extend Unique
  include PrimKey
  include ActiveWreckord
  attr_accessor :id, :name

  def self.table
    "artists"
  end

  def initialize
    self.class.all << self
  end

  def self.all
    @@artists ||= []
  end

end