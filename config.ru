require 'rubygems'
require 'bundler'

Bundler.require

require './lib/pitchforked'

require 'newrelic_rpm'

# Defined in ENV on Heroku. To try locally, start memcached and uncomment:
#ENV["MEMCACHE_SERVERS"] = "localhost"
if memcachier_servers = ENV["MEMCACHIER_SERVERS"]
  cache = Dalli::Client.new memcachier_servers.split(','), {
    username: ENV["MEMCACHIER_USERNAME"],
    password: ENV["MEMCACHIER_PASSWORD"]
  }
	use Rack::Cache, verbose: true, metastore: cache, entitystore: cache
end

run Pitchforked
