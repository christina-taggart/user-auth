require 'digest'

enable :sessions

get '/' do
  @logged_in = "Logged in!" if session[:user_id]
  @error = session[:error]
  session[:error] = nil
  erb :index
end

get '/secret_page' do
  if session[:user_id]
    erb :secret_page
  else
    redirect '/'
  end
end

post '/users/new' do
  new_user = User.new(email: params[:email], password: Digest::SHA256.hexdigest(params[:password]))
  if new_user.valid?
    new_user.save
    session[:user_id] = new_user.id
    redirect "/users/#{new_user.id}"
  else
    session[:error] = "Invalid info"
    redirect '/'
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user
end

post '/login' do
  if User.authenticate(params)
    session[:user_id] = User.where(email: params[:email]).first.id
    redirect '/secret_page'
  else
    session[:error] = "Authentication failed."
    redirect '/'
  end
end

post '/logout' do
  session[:user_id] = nil
  redirect '/'
end