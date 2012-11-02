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

reviewlinks = []
n = 1
doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
# while doc.css(".next-container").text
while n <= 10
  if doc.css(".next-container").text.include?("Next")
    doc.css(".object-grid ul li a").each do |review|
    reviewlinks << review["href"]
    end
    n += 1
    doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
  else
    doc.css(".object-grid ul li a").each do |review|
    reviewlinks << review["href"]
    end
    break
  end
end




reviewlinks.each do |review_link|

doc = Nokogiri::HTML(open("http://pitchfork.com#{review_link}"))

  artist = Artist.create_unique(doc.css("h1").first.children.text.gsub("'",""))
  label = Label.create_unique(doc.css("h3").first.children.text.split(";").first.gsub("'",""))
  unless Label.find(label.id) 
    label.save
  end
  unless Artist.find(artist.id)
    artist.save
  end
  album = Album.new
  album.name = doc.css("h2").first.children.text.gsub("'","")
  album.artist_id = Artist.find_by_name(artist.name)["id"]
  album.label_id = Label.find_by_name(label.name)["id"]
  album.save
  review = Review.new
  review.rating = doc.css(".score").text.to_f
  if doc.css(".bnm-label").text.include?("Best New Music")
    review.bnm = 1
  else
    review.bnm = 0
  end
  review.year = doc.css(".pub-date").text.split(",").last.strip
  review.author = doc.css("h4").children[1].text
  review.body = doc.css(".editorial").text
  review.album_id = Album.find_by_name(album.name)["id"]
  review.save

end
