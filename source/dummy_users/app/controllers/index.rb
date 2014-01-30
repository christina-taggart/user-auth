enable :sessions

get '/' do
  @logged_in = "Logged in!" if session[:logged_in]
  @error = session[:error]
  erb :index
end

post '/secret_page' do
  if session[:logged_in]
    erb :secret_page
  else
    redirect '/'
  end
end

post '/users/new' do
  new_user = User.new(params)
  if new_user.valid?
    new_user.save
    session[:logged_in] = 'true'
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
    session[:logged_in] = 'true'
    redirect '/secret_page'
  else
    session[:error] = "Authentication failed."
    redirect '/'
  end
end