class UsersController < ApplicationController
  
  def index
    if params[:'/search'].try(:[],:words)
      @users = User.search(params[:'/search'][:words])
    else
    @users = User.all
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
end