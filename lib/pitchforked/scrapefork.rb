require 'nokogiri'
require 'sqlite3'
require 'open-uri'

require_relative 'unique'
require_relative 'primkey'
require_relative 'activewreckord'
require_relative 'review'
require_relative 'album'
require_relative 'artist'
require_relative 'label'


doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/17205-luxury-problems/"))
  review = Review.new
  album = Album.new
  artist = Artist.new
  label = Label.new

  review.id = review.primary_key_iterator
  review.rating = doc.css(".score").text.to_f
  if doc.css(".bnm-label").text.include?("Best")
    review.bnm = 1
  else
    review.bnm = 0
  end
  review.year = doc.css(".pub-date").text.split(",").last.strip
  review.author = doc.css("h4").children[1].text
  review.body = doc.css(".editorial").text
  album.id = album.primary_key_iterator
  album.name = doc.css("h2").first.children.text
  artist.id = artist.primary_key_iterator
  artist.name = doc.css("h1").first.children.text
  label.id = label.primary_key_iterator
  label.name = doc.css("h3").first.children.text.split(";").first
  review.album_id = album.id
  album.artist_id = artist.id
  album.label_id = label.id

  review.save
  album.save
  artist.save
  label.save
