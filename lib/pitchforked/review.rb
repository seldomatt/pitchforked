require_relative 'album'

class Review 
  attr_accessor :id, :url, :rating, :year, :author, :body, :album_id

  def find_album
    Album.all.select {|a| a.id == self.album_id }
  end


end