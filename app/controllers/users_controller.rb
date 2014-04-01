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
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      redirect_to users_path(), notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end
end