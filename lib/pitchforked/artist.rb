require_relative 'album'

class Artist 
  extend Unique
  include PrimKey
  include ActiveWreckord::InstanceMethods
  extend ActiveWreckord::ClassMethods
  
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