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

end