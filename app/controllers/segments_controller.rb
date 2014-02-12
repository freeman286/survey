class SegmentsController < ApplicationController
  # GET /segments
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @segments = Segment.all
  end

  # GET /segments/1

  def show
    @segment = Segment.find(params[:id])
    @crud_state = "show"
  end

  # GET /segments/new
  def new
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
    if @diagnostic.segments.count > 15
      redirect_to diagnostic_admin_path(@diagnostic.id), alert: "Diagnostics can only have 16 segments"
    else
      @segment = Segment.new(:diagnostic_id => params[:diagnostic_id])
      @crud_state = "new"
    end
  end

  # GET /segments/1/edit
  def edit
    @segment = Segment.find(params[:id])
    @crud_state = "edit"
  end

  # POST /segments
  def create
    @segment = Segment.new(params[:segment])
    @crud_state = "create"

    if @segment.save
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully created.' 
    else
      render action: "new"
      
    end
  end

  def questions
    @segment =  Segment.find(params[:segment_id])
  end

  # PUT /segments/1
  def update
    @crud_state = "update"
    @segment = Segment.find(params[:id])

    if @segment.update_attributes(params[:segment])
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /segments/1
  def destroy
    @segment = Segment.find(params[:id])
    if @segment.destroy
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully deleted.'
    else
      redirect_to diagnostic_admin_path(@segment.diagnostic), alert: 'There was a problem deleting the Segment.'
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
