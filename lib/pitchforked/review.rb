require_relative 'album'

class Review < ActiveRecord::Base
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

end