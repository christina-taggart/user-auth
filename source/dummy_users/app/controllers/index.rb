enable :sessions

get '/' do
  @logged_in = "Logged in!" if session[:logged_in]
  erb :index
end

post '/secret_page' do
  if User.authenticate(params)
    session[:logged_in] = 'true'
    erb :secret_page
  else
    @error = "Email or password not recognized!"
    erb :index
  end
end