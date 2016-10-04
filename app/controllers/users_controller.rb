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

end