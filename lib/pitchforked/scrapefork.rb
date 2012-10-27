require 'nokogiri'
require 'sqlite3'
require 'open-uri'


require_relative 'review'
require_relative 'album'
require_relative 'artist'
require_relative 'label'


doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/17262-banks/"))
  review = Review.new
  album = Album.new
  artist = Artist.new
  label = Label.new

  review.id = 1
  review.rating = doc.css(".score").text.to_f
  review.year = doc.css(".pub-date").text.split(",").last.strip
  review.author = doc.css("h4").children[1].text
  review.body = doc.css(".editorial").text
  album.id = 1
  album.name = doc.css("h2").first.children.text
  artist.id = 1
  artist.name = doc.css("h1").first.children.text
  label.id = 1
  label.name = doc.css("h3").first.children.text.split(";").first
  review.album_id = album.id
  album.artist_id = artist.id
  album.label_id = label.id



puts review.inspect
