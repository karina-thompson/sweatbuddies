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

end


get '/' do
  redirect to '/users' if logged_in?
  erb :index
end

# Show sign up form
get '/users/new' do
    erb :signup, locals: {interests: Interest.all}
end

def profile_errors(user)
  puts user.errors.inspect
  messages = ''
  user.errors.full_messages.each do |message|
    messages += "<p>#{message}</p>"
  end
  flash[:warning] = messages  
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
  redirect to "/users"
end


#Create new event
post '/users/events' do
  event = Event.create(name: params[:name], location: params[:location], date_time: params[:date_time], details: params[:details], user_id: current_user.id, interest_id: params[:interest])

  if event.id == nil
    flash[:warning] = 'Please complete all fields'
    redirect to "/users/#{current_user.id}/events/create"
  end

  erb :event_listing, locals: {interests: Interest.all}
end


#Show event listings
get '/users/events' do
  erb :event_listing, locals: {interests: Interest.all }
end

#User home page when logged in
get '/users' do
  erb :users
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


