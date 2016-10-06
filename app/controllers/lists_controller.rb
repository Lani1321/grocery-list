class ListsController < ApplicationController

  # Index Action
  get '/lists' do
    redirect_if_not_logged_in
    @user = current_user
    @lists = @user.lists
    erb :'lists/show'
  end

 
end