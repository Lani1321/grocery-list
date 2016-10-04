class UsersController < ApplicationController

  get '/signup' do 
    if !session[:user_id]
      erb :"users/create_user"
    else
      redirect "/lists"
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == "" 
      redirect "/signup"
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/lists"
    end
  end

  get '/login' do
    if !logged_in?
       erb :'/users/login'
    else
       redirect to '/lists'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/lists"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
       session.clear
       redirect to '/login'
    else
      redirect '/'
     end

  end


end