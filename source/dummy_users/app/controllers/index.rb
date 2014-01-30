enable :sessions

get '/' do
  erb :index
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    session[:email] = params[:email]
    session[:name] = User.where(email: params[:email]).first.name
    redirect '/awesome_users_club'
  else
    redirect '/'
  end
end

get '/awesome_users_club' do
  if session[:email]
    erb :awesome_users_club
  else
    redirect '/'
  end
end
