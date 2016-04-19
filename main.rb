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

post '/user' do
  user = User.create(email: params[:email], user_name: params[:user_name], password: params[:password], location: params[:location], greeting: params[:greeting])
  # params[:interests].each do |interest|
    # InterestUser.create(user_id: user.id, interest_id: interest)
  # end

  user.interests = Interest.find(params[:interests].map(&:to_i))
  # p params[:interests]
  'Hiii'
end

get '/user' do
 
end 

