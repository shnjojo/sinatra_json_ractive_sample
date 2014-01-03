require 'sinatra'
require 'data_mapper'
require 'slim'

set :public_folder, File.dirname(__FILE__) + '/static'

class Task
  include DataMapper::Resource
  property :id,            Serial
  property :name,          String, required: true
  property :completed_at,  DateTime
  belongs_to :list
end

class List
  include DataMapper::Resource
  property :id,            Serial
  property :name,          String, required: true
  has n, :tasks, :constraint => :destroy
end

DataMapper.finalize

# Task Control

get '/' do
  @lists = List.all(:order => [:name])
  slim :index
end

post '/:id' do
  List.get(params[:id]).tasks.create params['task']
  redirect '/'
end

get '/:task' do
  @task = params[:task].split('-').join(' ').capitalize
  slim :task
end

delete '/task/:id' do
  Task.get(params[:id]).destroy
  redirect '/'
end

put '/task/:id' do
  task = Task.get params[:id]
  task.completed_at = task.completed_at.nil? ? Time.now : nil
  task.save
  redirect '/'
end

# List Control

post '/new/list' do
  List.create params['list']
  redirect '/'
end

delete '/list/:id' do
  List.get(params[:id]).destroy
  redirect '/'
end