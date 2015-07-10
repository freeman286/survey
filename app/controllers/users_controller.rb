class UsersController < ApplicationController

  before_filter :can_view

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

  private
  def can_view
	  if user_signed_in?
	    if !current_user.is_admin?
  	    redirect_to home_index_path(), alert: "You must be admin to do that"
  	  end
    end
	end
end
