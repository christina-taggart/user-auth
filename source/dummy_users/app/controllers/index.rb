enable :sessions

get '/' do
  erb :index
end

post '/log_in' do
  session[:logged_in] = User.authenticate(params[:email], params[:password])
  erb :index
end

get '/log_out' do
  session[:logged_in] = false
  erb :index
end

post '/create_account' do
  User.create(params)
  erb :index
end

get '/view' do
  if session[:logged_in]
    erb :view
  else
    erb :index
  end
end





