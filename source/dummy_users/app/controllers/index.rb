enable :sessions

helpers do
  def admin?
    session[:admin]
  end
end

get '/' do
  erb :index
end

get '/secret' do
  redirect '/' unless admin?
  erb :secret
end

get '/login' do
  session[:admin] = true
  redirect '/secret'
end

get '/register' do
  erb :register
end

post '/logout' do
  session[:admin] = false
  redirect '/'
end

post '/' do
  new_user = User.new(params)
  new_user.save if new_user.valid?
  erb :index
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:admin] = true
    redirect '/secret'
  else
    "That's not a valid email/password combination"
  end
end