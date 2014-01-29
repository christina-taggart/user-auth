require 'omniauth'
require 'omniauth-twitter'
require_relative '../../config/environment.rb'

use OmniAuth::Builder do
  provider :twitter, 'p0XXXXXXX', 'sZbuDZxzpx5XXXXXXXXXo'
end
 
configure do
  enable :sessions
end
 
helpers do
  def admin?
    session[:admin]
  end
end

get '/' do
  erb :index
end
 
get '/public' do
  "This is the public page - everybody is welcome!"
end
 
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "This is the private page - members only"
end
 
get '/login' do
  redirect to("/auth/twitter")
end
 
get '/logout' do
  session[:admin] = nil
  erb :logged_out
end

get '/auth/twitter/callback' do
  session[:admin] = true
  erb :logged_in
end

get '/auth/failure' do
  params[:message]
end

