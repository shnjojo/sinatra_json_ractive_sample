require 'bundler'
Bundler.require
require './app'
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:development.db")
run Sinatra::Application
