class ListsController < ApplicationController

  # Index Action
  get '/lists' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'lists/show'
  end

  # Create Action
  get '/lists/new' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = List.all   #i don't think I need this line
    erb :'/lists/create_list'
  end


  post '/lists/new' do
    @list = List.create(:name => params[:name], :user_id => current_user.id)
    @list.items.create(:name => params[:item])
    redirect "/lists"
    end

  # Update Action
  get '/lists/:id/edit' do
    if logged_in?
      @list = List.find_by_id(params[:id])
      if @list.user_id == session[:user_id]
       erb :'lists/edit'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end
  

  patch '/lists/:id' do
    @list = List.find_by_id(params[:id])
    @list.name = params[:name]
    @list.save
    redirect "/lists"
  end

  # Delete 
  get '/lists/:id/delete' do 
    @user = current_user
    @list = List.find_by_id(params[:id])
    erb :'/lists/delete'
  end

  delete '/lists/:id' do 
    @user = current_user
    @list = List.find_by_id(params[:id])
    @list.destroy
    redirect '/lists'
  end

end