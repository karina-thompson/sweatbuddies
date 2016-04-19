require 'sinatra'
require 'sinatra/reloader' 

require './db_config' 
require './models/user'
require './models/interest'





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
 
  user.interests = Interest.find(params[:interests])
  
  redirect to "/user/#{user.id}"
end

get '/user/:id' do
 # user profile page
 erb :user, locals: {user: User.find(params[:id])}
end 

get '/user/:id/matches' do
  me = User.find(params[:id])
  matches = []
  User.all.each do |user|
    matches << user if user != me && me.compatible?(user) 
  end

  erb :matches, locals: {matches: matches}
end


