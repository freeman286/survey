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

  def reset_password
    @user = User.find(params[:id])
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    password = (0...50).map { o[rand(o.length)] }.join[0..10]
    if @user.update_attributes(:password => password, :password_confirmation => password)
      redirect_to user_path(@user), notice: "The user's new password is #{password}."
    else
      redirect_to user_path(@user), alert: "The user's password could not be reset."
    end
  end



  private
  def can_view
    if !current_user.is_admin?
	    redirect_to home_index_path(), alert: "You must be admin to do that!"
	  end
	end
end
