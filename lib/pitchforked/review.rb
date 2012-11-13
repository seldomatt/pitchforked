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

  def self.artist_name_like(str)
    joins(:album => :artist).where("artists.name like ?", "%#{str}%")
  end

  def self.average_rating
    average(:rating).to_f
  end
  
end