require 'active_record'

class Review < ActiveRecord::Base
  belongs_to :album

  def self.artist_name_like(str)
    joins(:album => :artist).where("artists.name like ?", "%#{str}%")
  end

  def self.average_rating
    average(:rating).to_f
  end
  
end