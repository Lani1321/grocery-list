class ListsController < ApplicationController

  # Index Action
  get '/lists' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'lists/index'
  end

  # Create Action
  get '/lists/new' do
    redirect_if_not_logged_in
    @user = current_user
    # Do I need the line below?
    # @lists = List.all  
    erb :'/lists/new'
  end


  post '/lists/new' do
    list = List.create(:name => params[:name], :user_id => current_user.id)
    list.items.create(:name => params[:item])
    redirect "/lists"
    end

 
  get '/lists/:id/edit' do
    if logged_in? 
      # @list = List.find(params[:id])
      if @list = current_user.lists.find_by(params[:id]) 
       erb :'lists/show'
      else
        redirect to '/lists'
      end
    else
      redirect to '/login'
    end
  end
  
  # Update Action
  patch '/lists/:id' do
    @list = List.find(params[:id])
    @list.name = params[:name]
    @list.save
    redirect "/lists"
  end

  # Delete 
  # get '/lists/:id/delete' do 
  #   @user = current_user
  #   @list = List.find(params[:id]) #=> 
  #   erb :'/lists/delete'
  # end

  delete '/lists/:id' do 
    @user = current_user
    @list = List.find(params[:id])
    @list.destroy
    redirect '/lists'
  end

end