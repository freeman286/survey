class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter{ response.content_type = 'application/xhtml+xml' }
end
