require 'sinatra'
require 'sinatra/reloader' 
require_relative 'dbconfig'
require_relative 'review'
require_relative 'album'
require_relative 'label'
require_relative 'artist'


class Pitchforked < Sinatra::Base
  # configure :development do 
  #   register Sinatra::Reloader
  # end

  get '/' do 
    @reviews = Review.find(:all)
    @labels = Label.find(:all)
    @artists = Artist.find(:all)
    @avgrating = Review.average_rating
    @bnms = Review.bnm_percent
    @bnmrating = Review.bnm.average_rating
    @authors = Review.authors_count
    @prolific_auths = Review.top_20_authors
    @bnm_auths = Review.top_10_bnm_auths
    @bnm_labels = Review.most_bnm_labels
    @bnm_artists = Review.most_bnm_artists
    @rating = Review.artist_name_like("bear").average_rating
    @perfect = Review.perfect_ratings
    @zero = Review.zero_ratings
    @toplabels = Review.top_rated_labels
    @bottomlabels = Review.lowest_rated_labels
    erb :index
  end  


  


end



Pitchforked.run!