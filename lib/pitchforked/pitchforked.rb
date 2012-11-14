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
    @rating = Review.artist_name_like("bear").average_rating
    erb :index
  end  


  


end



Pitchforked.run!