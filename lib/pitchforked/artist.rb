require_relative 'album'

class Artist 
  include ActiveWreckord::InstanceMethods
  extend ActiveWreckord::ClassMethods
  
  attr_accessor :id, :name

  def initialize
    self.class.all << self
  end

  def self.all
    @@artists ||= []
  end

end