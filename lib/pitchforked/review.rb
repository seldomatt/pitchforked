# require_relative 'album'
require 'active_record'
require_relative 'album'
require_relative 'artist'

class Review < ActiveRecord::Base
  belongs_to :album
  # include ActiveWreckord::InstanceMethods
  # extend ActiveWreckord::ClassMethods
  # attr_accessor :id, :url, :rating, :bnm, :year, :author, :body, :album_id

  # def initialize
  #   self.class.all << self
  # end

  # def self.all
  #   @@reviews ||= []
  # end

end