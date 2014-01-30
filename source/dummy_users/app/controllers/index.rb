get '/' do
  erb :index
end

post '/login' do
  if User.authenticate(params[:email], params[:password])
    redirect '/awesome_users_club'
  else
    redirect '/'
  end
end

get '/awesome_users_club' do
  erb :awesome_users_club
end
