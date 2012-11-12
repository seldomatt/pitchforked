require 'active_record'
require_relative 'review'
require_relative 'artist'

class Album < ActiveRecord::Base
  belongs_to :artist
  # include ActiveWreckord::InstanceMethods
  # extend ActiveWreckord::ClassMethods
  # attr_accessor :id, :name, :artist_id, :label_id

  # def initialize
  #   self.class.all << self
  # end


  # def self.all
  #   @@albums ||= []
  # end

end