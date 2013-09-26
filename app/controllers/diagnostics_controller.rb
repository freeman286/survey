class DiagnosticsController < ApplicationController
  # GET /diagnostics
  # GET /diagnostics.json
  def index
    @diagnostics = Diagnostic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diagnostics }
    end
  end

  # GET /diagnostics/1
  # GET /diagnostics/1.json
  def show
    @diagnostic = Diagnostic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diagnostic }
    end
  end

  # GET /diagnostics/new
  # GET /diagnostics/new.json
  def new
    @diagnostic = Diagnostic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diagnostic }
    end
  end

  # GET /diagnostics/1/edit
  def edit
    @diagnostic = Diagnostic.find(params[:id])
  end

  # POST /diagnostics
  # POST /diagnostics.json
  def create
    @diagnostic = Diagnostic.new(params[:diagnostic])

    respond_to do |format|
      if @diagnostic.save
        format.html { redirect_to @diagnostic, notice: 'Diagnostic was successfully created.' }
        format.json { render json: @diagnostic, status: :created, location: @diagnostic }
      else
        format.html { render action: "new" }
        format.json { render json: @diagnostic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diagnostics/1
  # PUT /diagnostics/1.json
  def update
    @diagnostic = Diagnostic.find(params[:id])

    respond_to do |format|
      if @diagnostic.update_attributes(params[:diagnostic])
        format.html { redirect_to @diagnostic, notice: 'Diagnostic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diagnostic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnostics/1
  # DELETE /diagnostics/1.json
  def destroy
    @diagnostic = Diagnostic.find(params[:id])
    @diagnostic.destroy

    respond_to do |format|
      format.html { redirect_to diagnostics_url }
      format.json { head :no_content }
    end
  end
end
