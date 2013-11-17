class HomeController < ApplicationController
  def index
    @diagnostics = Diagnostic.all
  end
end
