require 'sinatra'
require 'data_mapper'
require 'haml'
require 'json'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite:development.db")
set :public_folder, File.dirname(__FILE__) + '/static'

class Task
  include DataMapper::Resource
  property :id,            Serial
  property :name,          String, required: true
  property :completed_at,  DateTime
end

DataMapper.finalize

# Task Control

get '/' do
  @tasks = Task.all
  @tasks = @tasks.to_json
  haml :index
end

post '/' do
  @json_data = JSON.parse(request.body.read.to_s)
end