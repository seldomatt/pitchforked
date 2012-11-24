require 'nokogiri'
require 'sqlite3'
require 'open-uri'
require 'active_record'

require_relative 'dbconfig'
require_relative 'review'
require_relative 'album'
require_relative 'artist'
require_relative 'label'

reviewlinks = []
n = 1
doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
while doc.css(".next-container").text
  if doc.css(".next-container").text.include?("Next")
    doc.css(".object-grid ul li a").each do |review|
      unless Review.find_by_url(review["href"])
        reviewlinks << review["href"]
      end
    end
    n += 1
    doc = Nokogiri::HTML(open("http://pitchfork.com/reviews/albums/#{n}/"))
  else
    doc.css(".object-grid ul li a").each do |review|
      unless Review.find_by_url(review["href"])
        reviewlinks << review["href"]
      end
    end
    break
  end
end




reviewlinks.each do |review_link|
begin
  doc = Nokogiri::HTML(open("http://pitchfork.com#{review_link}"))
  artist = Artist.find_or_create_by_name(doc.css("h1").first.children.text.gsub("'",""))
  label = Label.find_or_create_by_name(doc.css("h3").first.children.text.split(";").first.gsub("'","").strip)
  name = doc.css("h2").first.children.text.gsub("'","")
  album = Album.create(:name => name, :artist => artist, :label => label)
  review = Review.new
  review.url = review_link
  review.rating = doc.css(".score").text.to_f
  if doc.css(".bnm-label").text.include?("Best New Music")
    review.bnm = 1
  else
    review.bnm = 0
  end
  review.year = doc.css(".pub-date").text.split(",").last.strip
  review.author = doc.css("h4").children[1].text
  review.body = doc.css(".editorial").text
  review.album = album
  if review.save 
    puts "Saved #{review} from #{review.year}" 
  else
    puts "Error Saving #{review}"
  end
rescue => e
  puts "Error scraping #{review_link}, error => #{e}"
end


end
