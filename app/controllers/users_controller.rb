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

  # Tried putting a validates_presence_of in controller, but I get a no method error
  post '/signup' do  
    @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    # binding.pry
    if @user.valid?
      flash[:message] = "Congrats! You've signed up!"
      session[:user_id] = @user.id
    else
     flash[:message] = "Please fill out all the required fields"
    end
    
    redirect "/"
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