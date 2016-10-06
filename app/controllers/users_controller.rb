require 'rack-flash'

class UsersController < ApplicationController
  enable :sessions
  use Rack::Flash

  get '/signup' do 
    if !logged_in?
      erb :"users/create_user"
    else
      redirect "/lists"
    end
  end

  post '/signup' do  
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.valid?
      flash[:message] = "Congrats! You've signed up!"
      session[:user_id] = @user.id
    elsif
     flash[:message] = "Please fill out all the required fields"
        redirect "/signup"
    elsif
      flash[:error] = "Uh-oh, someone already has that username, please choose another"
      
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
      redirect "/"
    else
    flash[:message] = "Oops! You need both username and password to login"
      redirect to '/login'
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