class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_host

  after_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get?
    if (request.path != "/login" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/logout" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    return root_path if session[:previous_url] == "/register"
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    login_path
  end

  def after_sign_up_path_for(resource)
    home_index_path
  end

  private
  def get_host
    @host = "http://" + (request.host || "spider-diagnostic.herokuapp.com/") + ":" + (request.port.to_s)
  end
end
