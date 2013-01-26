#require 'sinatra/base'
#require 'sinatra/reloader' 
#require_relative 'dbconfig'

class Pitchforked < Sinatra::Base
  register Sinatra::ActiveRecordExtension
# configure :development do 
#   register Sinatra::Reloader
# end
require 'sinatra/activerecord'
  configure :development do 
    set :database, 'sqlite3:///lib/pitchforked.db'
  end
require_relative 'review'
require_relative 'album'
require_relative 'label'
require_relative 'artist'


  get '/' do 

    cache_control :public, :must_revalidate, :max_age => 60

    @reviews = Review.find(:all)
    @labels = Label.find(:all)
    @artists = Artist.find(:all)
    @authors = Review.authors_count
    @prolific_auths = Review.top_20_authors
    @topauths = Review.highest_rated_auths
    @bottomauths = Review.lowest_rated_auths
    @bnm_auths = Review.top_10_bnm_auths
    @bnm_labels = Review.most_bnm_labels
    @bnm_artists = Review.most_bnm_artists
    @topartists = Review.highest_rated_artists  
    @bottomartists = Review.lowest_rated_artists
    @toplabels = Review.top_rated_labels
    @bandnames = Review.band_names.average_rating
    @avgrating = Review.average_rating
    @avgbyyear = Review.avg_rating_per_year
    @perfect = Review.perfect_ratings
    @zero = Review.zero_ratings
    @arielpink = Review.body_name_drop("ariel pink")
    @cobain = Review.body_name_drop("cobain")
    @loureed = Review.body_name_drop("lou reed")
    @brianwilson = Review.body_name_drop("brian wilson")
    @brianeno = Review.body_name_drop("brian eno")
    @davidbyrne = Review.body_name_drop("david byrne")
    @johnlennon = Review.body_name_drop("lennon")
    @jaredleto = Review.body_name_drop("jared leto")
    @springsteen = Review.body_name_drop("springsteen")
    @yorke = Review.body_name_drop("thom yorke")
    @guitars = Review.body_name_drop(" guitar ")
    @synths = Review.body_name_drop(" synth ")
    @samplers = Review.body_name_drop(" sampler ")
    @zithers = Review.body_name_drop(" zither ")
    @didges = Review.body_name_drop(" didgeridoo ")
    @electro02 = Review.body_name_drop_by_year("electroclash", "2002")
    @electro03 = Review.body_name_drop_by_year("electroclash", "2003")
    @electro04 = Review.body_name_drop_by_year("electroclash", "2004")
    @electro12 = Review.body_name_drop_by_year("electroclash", "2012")
    @chill09 = Review.body_name_drop_by_year("chillwave", "2009")
    @chill10 = Review.body_name_drop_by_year("chillwave", "2010")
    @chill11 = Review.body_name_drop_by_year("chillwave", "2011")
    @chill12 = Review.body_name_drop_by_year("chillwave", "2012")
    @balearic07 = Review.body_name_drop_by_year("balearic", "2007")
    @balearic08 = Review.body_name_drop_by_year("balearic", "2008")
    @balearic09 = Review.body_name_drop_by_year("balearic", "2009")
    @balearic10 = Review.body_name_drop_by_year("balearic", "2010")
    @bottomlabels = Review.lowest_rated_labels
    @bnms = Review.bnm_percent
    @bnmrating = Review.bnm.average_rating
    erb :index2
  end

end



#Pitchforked.run!
