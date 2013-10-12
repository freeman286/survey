class DiagnosticsController < ApplicationController
  # GET /diagnostics
  # GET /diagnostics.json
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]
  
  def admin
     @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end
  
  def index
    @diagnostics = Diagnostic.all
  end

  # GET /diagnostics/1
  def show
    @diagnostic = Diagnostic.find(params[:id])
    @crud_state = "show"
  end

  # GET /diagnostics/new
  def new
    @diagnostic = Diagnostic.new
    @crud_state = "new"
  end

  # GET /diagnostics/1/edit
  def edit
    @diagnostic = Diagnostic.find(params[:id])
    @crud_state = "edit"
  end

  # POST /diagnostics
  def create
    @diagnostic = Diagnostic.new(params[:diagnostic])
    @crud_state = "create"

    if @diagnostic.save
      redirect_to @diagnostic, notice: 'Diagnostic was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /diagnostics/1
  def update
    @diagnostic = Diagnostic.find(params[:id])
    @crud_state = "update"

    
    if @diagnostic.update_attributes(params[:diagnostic])
      redirect_to @diagnostic, notice: 'Diagnostic was successfully updated.'
    else
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
  def can_edit
	  if user_signed_in?
	    if !current_user.is_admin?
  	    redirect_to :back, alert: "You must be admin to do that"
  	  end
    end
	end
end
