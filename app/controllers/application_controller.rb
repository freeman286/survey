class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_host

  def after_sign_in_path_for(resource)
    diagnostics_path
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
