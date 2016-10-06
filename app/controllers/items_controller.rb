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

  # Update Action
  get '/items/:id/edit' do
    @item = Item.find_by_id(params[:id])
      erb :'/items/edit'
  end

  patch '/items/:id' do
    @item = Item.find_by_id(params[:id])
    @item.name = params[:name]
    @item.save
    redirect '/items'
  end

  # Delete action
  get '/items/:id/delete' do 
    @item = Item.find_by_id(params[:id])
    erb :'/items/delete'
  end

  delete '/items/:id' do 
    @item = Item.find_by_id(params[:id])
    @item.destroy
    redirect '/items'
  end

end