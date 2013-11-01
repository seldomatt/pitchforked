require 'sinatra'
require 'sinatra/activerecord'
require 'dalli'
#require 'rack-cache'
require 'memcachier'


configure :production do

	require 'newrelic_rpm'

end

class Pitchforked < Sinatra::Base
	register Sinatra::ActiveRecordExtension

	require 'sinatra/activerecord'

	configure :development do
		set :database, 'postgres:///pitchforked2'
	end

	configure :production do

		db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///pitchforked2')

		ActiveRecord::Base.establish_connection(
			:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
			:host => db.host,
			:port => db.port,
			:username => db.user,
			:password => db.password,
			:database => db.path[1..-1],
			:encoding => 'utf8'
		)
	end

	require_relative 'review'
	require_relative 'album'
	require_relative 'label'
	require_relative 'artist'

	helpers do

		def thousandize(number)
			num = number.to_s
			new_num = ""
			digits = number.to_s.length
			if digits > 3
				num.scan(/\d/).reverse.each_with_index do |n, i|
					if  i != 0 && i % 3 == 0
						new_num << ",#{n}"
					else
						new_num << n
					end
				end
				new_num.reverse.gsub(/^,/, "")
			else
				num
			end
		end
	end

#set :cache, Dalli::Client.new  

	get '/' do

		cache_control :public, max_age: 60

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
		@arielpink = Review.body_name_drop("Ariel Pink")
		@cobain = Review.body_name_drop("Cobain")
		@loureed = Review.body_name_drop("Lou Reed")
		@brianwilson = Review.body_name_drop("Brian Wilson")
		@brianeno = Review.body_name_drop("Brian Eno")
		@davidbyrne = Review.body_name_drop("David Byrne")
		@johnlennon = Review.body_name_drop("Lennon")
		@jaredleto = Review.body_name_drop("Jared Leto")
		@springsteen = Review.body_name_drop("Springsteen")
		@yorke = Review.body_name_drop("Thom Yorke")
		@guitars = Review.body_name_drop(" guitar ")
		@synths = Review.body_name_drop(" synth ")
		@samplers = Review.body_name_drop(" sampler ")
		@zithers = Review.body_name_drop(" zither ")
		@didges = Review.body_name_drop(" didgeridoo ")
		@bottomlabels = Review.lowest_rated_labels
		@bnms = Review.bnm_percent
		@bnmrating = Review.bnm.average_rating
		erb :index2
	end

end

