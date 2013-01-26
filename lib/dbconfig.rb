require 'active_record'
#require 'sinatra/activerecord'

#configure :development do 
# set :database, 'sqlite://lib/pitchforked.db'
#end

ActiveRecord::Base.establish_connection(
 :adapter => "sqlite3",
 :database => "lib/pitchforked.db"
 )
