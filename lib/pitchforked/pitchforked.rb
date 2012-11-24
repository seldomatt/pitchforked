require 'sinatra'
require_relative 'dbconfig'
require_relative 'review'
require_relative 'album'
require_relative 'label'
require_relative 'artist'


class Pitchforked < Sinatra::Base

  get '/' do 
    @reviews = Review.find(:all)
    @labels = Label.find(:all)
    @artists = Artist.find(:all)
    @avgrating = Review.average_rating
    @bnms = Review.bnm_percent
    @bnmrating = Review.bnm.average_rating
    @authors = Review.authors_count
    @prolific_auths = Review.top_20_authors
    @rating = Review.artist_name_like("bear").average_rating
    erb :index
  end  


  


end



Pitchforked.run!