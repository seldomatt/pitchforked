require 'rubygems'
require 'bundler'

Bundler.require

#require './lib/dbconfig'
require './lib/pitchforked'

require 'newrelic_rpm'


run Pitchforked
