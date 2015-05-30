class ResponsesController < ApplicationController
  # GET /responses
  # GET /responses.json

  # GET /responses/new
  # GET /responses/new.json
  def new
    @segment = Segment.find(params[:segment_id])
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @response }
    end
  end

  # GET /responses/1/edit
  def edit
    @response = Response.find(params[:id])
    @segment = @response.segment
  end

  # POST /responses
  # POST /responses.json
  def create
    @segment = Segment.find(params[:response][:segment_id])
    @response = Response.new(params[:response])

    if @response.save
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /responses/1
  # PUT /responses/1.json
  def update
    @segment = Segment.find(params[:response][:segment_id])
    @response = Response.find(params[:id])

    if @response.update_attributes(params[:response])
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Segment was successfully created.'
    else
      render action: "edit"
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.json
  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    @segment = @response.segment

    if @response.destroy
      redirect_to diagnostic_admin_path(@segment.diagnostic), notice: 'Response was successfully deleted.'
    else
      redirect_to diagnostic_admin_path(@segment.diagnostic), alert: 'There was a problem deleting the Response.'
    end
  end
end
