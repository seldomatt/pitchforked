require 'active_record'

class Album < ActiveRecord::Base
  belongs_to :artist
  belongs_to :label

end