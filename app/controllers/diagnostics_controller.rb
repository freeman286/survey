class DiagnosticsController < ApplicationController
  # GET /diagnostics
  # GET /diagnostics.json
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]
  before_filter :check_paid , only: [:show_pdf]

  def admin
     @diagnostic = Diagnostic.find(params[:diagnostic_id])
  end

  def all
    @diagnostics = Diagnostic.all
  end

  def chart
    @diagnostics = Diagnostic.all
  end

  def index
    @diagnostics = Diagnostic.all
    @diagnostics.each do |diagnostic|
      diagnostic.make_chart_for_user(current_user.id) if user_signed_in?
    end
  end

  # GET /diagnostics/1
  def show
    @diagnostic = Diagnostic.find(params[:id])
    @segment = Segment.find(params[:segment_id]) if params[:segment_id]
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
    @diagnostic.make_wheel()

    if @diagnostic.update_attributes(params[:diagnostic])
      @diagnostic.make_wheel()
      redirect_to diagnostics_url, notice: 'Diagnostic was successfully updated.'
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

  def click
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
    @segment = @diagnostic.segment_from_x_y_rotation(params[:x],params[:y],params[:rotation])
    render action: "show"
  end

  def buy_now
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
    begin
      @transaction = Transaction.create!(:user_id => current_user, :diagnostic_id => @diagnostic.id)
    rescue
      @transaction = current_user.transactions.where(:diagnostic_id => diagnostic.id).first
    end
  end

  def show_pdf
    @diagnostic = Diagnostic.find(params[:diagnostic_id])
    @diagnostic.pdf_for_user(current_user.id)
    send_file "#{Rails.root}/pdfs/#{@diagnostic.id}-#{current_user.id}.pdf", :type=>"application/pdf", :x_sendfile=>true
  end

  private
  def can_edit
	  if user_signed_in?
	    if !current_user.is_admin?
  	    redirect_to :back, alert: "You must be admin to do that"
  	  end
    end
	end

  def check_paid
    if current_user.transactions.where(:completed => true).where(:diagnostic_id => params[:diagnostic_id]).empty?
      redirect_to :root, alert: "You have not paid for that"
    end
  end
end
