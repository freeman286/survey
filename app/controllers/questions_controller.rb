class QuestionsController < ApplicationController
  # GET /questions
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    @crud_state = "show"
  end

  # GET /questions/new
  def new
    @question = Question.new(:segment_id => params[:segment_id])
    @crud_state = "new"
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
    @crud_state = "edit"
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])
    @crud_state = "create"
    
    if @question.save
      redirect_to diagnostic_admin_path(@question.segment.diagnostic.id), notice: 'Question was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /questions/1
  def update
    @question = Question.find(params[:id])
    @crud_state = "update"

    if @question.update_attributes(params[:question])
      redirect_to diagnostic_admin_path(@question.segment.diagnostic.id), notice: 'Question was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      redirect_to diagnostic_admin_path(@question.segment.diagnostic.id), notice: 'Question was successfully deleted.'
    else
      redirect_to diagnostic_admin_path(@question.segment.diagnostic.id), alert: 'Question was not deleted.'
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
