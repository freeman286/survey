class SegmentsController < ApplicationController
  # GET /segments

  def index
    @segments = Segment.all
  end

  # GET /segments/1

  def show
    @segment = Segment.find(params[:id])
  end

  # GET /segments/new
  def new
    @segment = Segment.new(:diagnostic_id => params[:diagnostic_id])
  end

  # GET /segments/1/edit
  def edit
    @segment = Segment.find(params[:id])
  end

  # POST /segments
  def create
    @segment = Segment.new(params[:segment])

    if @segment.save
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully created.' 
    else
      render action: "new"
    end
  end

  # PUT /segments/1
  # PUT /segments/1.json
  def update
    @segment = Segment.find(params[:id])

    if @segment.update_attributes(params[:segment])
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully updated.'
    else
      render action: "edit", alert: "There was a problem editting the Segment"
    end

  end

  # DELETE /segments/1
  # DELETE /segments/1.json
  def destroy
    @segment = Segment.find(params[:id])
    if @segment.destroy
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully deleted.'
    else
      redirect_to diagnostic_admin_path(@segment.diagnostic), alert: 'There was a problem deleting the Segment.'
    end
  end
end
