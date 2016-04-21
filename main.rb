require 'sinatra'
require 'sinatra/reloader' 
require 'sinatra/flash'

require './db_config' 
require './models/user'
require './models/interest'
require './models/event'


after do
  ActiveRecord::Base.connection.close
end

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def alert_message
    return '' if flash(:flash).empty?
    messages = flash(:flash).map {|message| "  <div class='alert alert-#{message[0]}'>#{message[1]}</div>\n"}

    html = <<-HTML
      <div id="flash container">
        <div class="row col-md-6 col-md-offset-3">
          #{messages.join}
        </div>
      </div>
    HTML
    html
  end

  def profile_errors(user)
    if user.errors.messages[:email]
      flash[:danger] = user.errors.messages[:email].join
    else 
      flash[:warning] = "Please complete all fields" 
    end
  end

end


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
  user = User.create(email: params[:email], user_name: params[:user_name], password: params[:password], location: params[:location], greeting: params[:greeting])

  if user.id == nil          #if AR validations have failed
    profile_errors(user)
    redirect to '/users/new'
  end
  
  if params[:interests] == [] 
    flash[:warning] = 'Please select at least one interest'
    redirect to '/users/new'
  end

  user.interests = Interest.find(params[:interests])

  session[:user_id] = user.id
  redirect to "/users"
end

#User home page when logged in
get '/users' do
  erb :users
end

# Show user profile
get '/users/:id' do
 erb :profile, locals: {user: User.find(params[:id])}
end 


#Display matching users
get '/users/:id/search_results' do
  redirect to '/' unless logged_in?

  me = User.find(current_user.id)
  matches = []
  User.all.each do |user|
    if user != me && me.compatible?(user) 
     matches << user 
   end
  end

  erb :search_results, locals: {matches: matches}
end


#Create event form
get '/users/:id/events/create' do
  erb :create_event, locals: {interests: Interest.all, user: User.find(params[:id])}
end


#Create new event
post '/users/:id/events' do
  event = Event.create(name: params[:name], location: params[:location], date_time: params[:date_time], details: params[:details], user_id: current_user.id, interest_id: params[:interest])

  if event.id == nil
    flash[:warning] = 'Please complete all fields'
    redirect to "/users/#{current_user.id}/events/create"
  end

  erb :event_listing, locals: {interests: Interest.all}
end


#Show event listings
get '/users/:id/events' do
  erb :event_listing, locals: {interests: Interest.all, events: Event.all}
end


#show edit profile page
get '/users/:id/edit' do
  if logged_in?
    erb :edit, locals: {interests: Interest.all }
  end
end


#update profile data
put '/users/:id' do
  user = User.find(current_user.id)
  user.update(email: params[:email], user_name: params[:user_name], password: params[:password], location: params[:location], greeting: params[:greeting])

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


