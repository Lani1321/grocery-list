class ItemsController < ApplicationController 

  get '/items' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'items/show'
  end

  # Create Action
  get '/items/new' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = List.all
    erb :'/items/new'
  end

  post '/items/new' do
    Item.create(:name => params[:name], :list_id => params[:list_id])
    redirect '/items'
    end

 
end