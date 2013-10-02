class DiagnosticsController < ApplicationController
  # GET /diagnostics
  # GET /diagnostics.json
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_admin, only: [:new, :create, :edit, :update, :destroy]
  
  def admin
     @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end
  
  def index
    @diagnostics = Diagnostic.all
  end

  # GET /diagnostics/1
  def show
    @diagnostic = Diagnostic.find(params[:id])
  end

  # GET /diagnostics/new
  def new
    @diagnostic = Diagnostic.new
  end

  # GET /diagnostics/1/edit
  def edit
    @diagnostic = Diagnostic.find(params[:id])
  end

  # POST /diagnostics
  def create
    @diagnostic = Diagnostic.new(params[:diagnostic])

    if @diagnostic.save
      redirect_to @diagnostic, notice: 'Diagnostic was successfully created.'
    else
      flash.now[:alert] = 'Diagnostic was not created.'
      render action: "new"
    end
  end

  # PUT /diagnostics/1
  def update
    @diagnostic = Diagnostic.find(params[:id])

    
    if @diagnostic.update_attributes(params[:diagnostic])
      redirect_to @diagnostic, notice: 'Diagnostic was successfully updated.'
    else
      flash.now[:alert] = 'Diagnostic was not updated.'
      render action: "edit"
    end
  end

  # DELETE /diagnostics/1
  def destroy
    @diagnostic = Diagnostic.find(params[:id])
    if @diagnostic.destroy
      redirect_to diagnostics_url, notice: 'Diagnostic was successfully deleted.'
    else                         
      redirect_to diagnostics_url, alert: 'Diagnostic was not deleted.'
    end
  end
  
  private
	def check_admin
	  if !current_user.is_admin?
	    redirect_to :back, alert: "You must be admin to do that"
	  end
	end
end
