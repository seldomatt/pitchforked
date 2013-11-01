require 'rubygems'
require 'bundler'

Bundler.require

require './lib/pitchforked'

require 'newrelic_rpm'

# Defined in ENV on Heroku. To try locally, start memcached and uncomment:
#ENV["MEMCACHE_SERVERS"] = "localhost"
if memcache_servers = ENV["MEMCACHIER_SERVERS"]
	use Rack::Cache,
			verbose: true,
			metastore:   "memcachier://#{memcache_servers}",
			entitystore: "memcachier://#{memcache_servers}"
end

run Pitchforked
