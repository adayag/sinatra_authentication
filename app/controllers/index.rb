get '/' do
 @users = User.all
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
  erb :sign_in
end

post '/sessions' do
  @user = User.authenticate(params[:email],params[:password])
  if @user
    session[:user_id] = @user.id
    redirect to ('/')
  else
    erb :sign_in
  end
end

get '/sessions/:id' do
  session.clear
  redirect to '/'
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
   @user = User.new(params[:user])
  if @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect to '/'
  else
    @errors = @user.errors
    erb :sign_up
  end
end
