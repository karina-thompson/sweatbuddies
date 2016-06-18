require 'sinatra'
require 'sinatra/reloader' 
require 'sinatra/flash'

require './db_config' 
require './helpers'
require './models/user'
require './models/interest'
require './models/event'

after do
  ActiveRecord::Base.connection.close
end

set :sessions, key: "fald34yg2918", expire_after: 14400, secret: "*&(^B23432f34"

get '/' do
  redirect to '/users' if logged_in?
  erb :index
end

# Show sign up form
get '/users/new' do
    erb :signup, locals: {interests: Interest.all}
end

# Create new profile
post '/users' do
  user = User.new(email:    params[:email],    user_name: params[:user_name],
                  password: params[:password], location: params[:location],
                  greeting: params[:greeting])
  
  user.interests = Interest.find(params[:interests]) if params[:interests]  
  if user.valid?
    user.save 
  else
    profile_errors(user)
    redirect to '/users/new'
  end
  session[:user_id] = user.id
  redirect to '/users'
end

#Create new event
post '/users/events' do
  event = Event.create( name:      params[:name],         location:    params[:location],
                        date_time: params[:date_time],    details:     params[:details],
                        user_id:   current_user.id,       interest_id: params[:interest])
  if event.id == nil
    flash[:warning] = 'Please complete all fields'
    redirect to "/users/#{current_user.id}/events/create"
  end
  erb :event_listing, locals: {interests: Interest.all}
end

#Show event listings
get '/users/events' do
  erb :event_listing, locals: {interests: Interest.all, events: Event.all }
end

#User home page when logged in
get '/users' do
  erb :users
end

#Display matching users
get '/users/:id/search_results' do
  redirect to '/' unless logged_in?
  matches = []
  User.all.each do |user|
    if user != current_user && current_user.compatible?(user) 
      matches << user 
    end
  end
  matches.sort_by! do |match| 
    common = match.common_interests(current_user)
    [-common.count, common.first.name]
  end
  erb :search_results, locals: {matches: matches}
end

#Create event form
get '/users/events/create' do
  erb :create_event, locals: {interests: Interest.all, user: current_user}
end

#show edit profile page
get '/users/edit' do
  if logged_in?
    erb :edit, locals: {interests: Interest.all }
  end
end

# Show user profile
get '/users/:id' do
  erb :profile, locals: {user: User.find(params[:id])}
end 

#update profile data
put '/users/:id' do
  user = User.find(current_user.id)
  user.update(email:    params[:email],    user_name:   params[:user_name], 
              password: params[:password], location:    params[:location], 
              greeting: params[:greeting])
  user.interests = []
  user.interests = Interest.find(params[:interests])
  redirect to "/users/#{user.id}"
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to "/users"
  else
    flash[:warning] = 'Sorry, that login was incorrect'
    redirect to '/'
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect to '/'
end


