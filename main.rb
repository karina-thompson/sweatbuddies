require 'sinatra'
require 'sinatra/reloader' 

require './db_config' 
require './models/user'
require './models/interest'
require './models/interest_user'




after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/user/new' do
  @interests = Interest.all 
  erb :signup
end





