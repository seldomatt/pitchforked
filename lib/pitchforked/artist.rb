require_relative 'album'

class Artist 
  extend Unique
  include PrimKey
  attr_accessor :id, :name

  def initialize
    self.class.all << self
  end

  def self.all
    @@artists ||= []
  end

end