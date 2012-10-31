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

# reviewlinks = []
# n = 1
# doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
# while doc.css(".next-container").text
#   if doc.css(".next-container").text.include?("Next")
#     doc.css(".object-grid ul li a").each do |review|
#     reviewlinks << review["href"]
#     end
#     n += 1
#     doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
#   else
#     doc.css(".object-grid ul li a").each do |review|
#     reviewlinks << review["href"]
#     end
#     break
#   end
# end

reviewlinks = ["/reviews/albums/10082-fluorescent-grey-ep/", "/reviews/albums/12991-rainwater-cassette-exchange/"]


reviewlinks.each do |review_link|

doc = Nokogiri::HTML(open("http://pitchfork.com#{review_link}"))
  review = Review.new
  album = Album.new
  # artist = Artist.new
  # label = Label.new

  review.id = review.primary_key_iterator
  review.rating = doc.css(".score").text.to_f
  if doc.css(".bnm-label").text.include?("Best New Music")
    review.bnm = 1
  else
    review.bnm = 0
  end
  review.year = doc.css(".pub-date").text.split(",").last.strip
  review.author = doc.css("h4").children[1].text
  review.body = doc.css(".editorial").text
  album.id = album.primary_key_iterator
  album.name = doc.css("h2").first.children.text
  artist = Artist.create_unique(doc.css("h1").first.children.text)
  artist.id ||= artist.primary_key_iterator
  # artist.name = doc.css("h1").first.children.text
  label = Label.create_unique(doc.css("h3").first.children.text.split(";").first)
  label.id ||= label.primary_key_iterator
  # label.name = doc.css("h3").first.children.text.split(";").first
  review.album_id = album.id
  album.artist_id = artist.id
  album.label_id = label.id

  review.save
  album.save
  unless Artist.find(artist.id)
    artist.save
  end
  unless Label.find(label.id) 
    label.save
  end

end
