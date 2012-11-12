require 'sinatra'
require_relative 'dbconfig'
require_relative 'review'

class Pitchforked < Sinatra::Base

  get '/' do 
    @reviews = Review.find(:all)
    @rating = Review.joins(:album => :artist).where("artists.name like ?", "%bear%").average(:rating).to_f
    erb :index
  end  


  


end



Pitchforked.run!