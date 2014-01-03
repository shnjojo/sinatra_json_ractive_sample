require 'bundler'
Bundler.require
require './app'
DataMapper.setup(:default, "postgres://erqsbqgusqtfnr:i-NFAOpN4zf_ZAIseCxlV1yWev@ec2-54-197-237-171.compute-1.amazonaws.com:5432/d8scur2juml2e" || "sqlite:development.db")
run Sinatra::Application
