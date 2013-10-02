class SubQuestionsController < ApplicationController
  # GET /sub_questions
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sub_questions = SubQuestion.all
  end

  # GET /sub_questions/1
  def show
    @sub_question = SubQuestion.find(params[:id])
  end

  # GET /sub_questions/new
  def new
    @sub_question = SubQuestion.new(question_id: params[:question_id])
  end

  # GET /sub_questions/1/edit
  def edit
    @sub_question = SubQuestion.find(params[:id])
  end

  # POST /sub_questions
  def create
    @sub_question = SubQuestion.new(params[:sub_question])
    
    if @sub_question.save
      redirect_to diagnostic_admin_path(@sub_question.question.segment.diagnostic.id), notice: 'Sub-Question was successfully created.'
    else
      flash.now[:alert] = 'Sub-Question was not created.'
      render action: "new"
    end
  end

  # PUT /sub_questions/1
  def update
    @sub_question = SubQuestion.find(params[:id])

    if @sub_question.update_attributes(params[:sub_question])
      redirect_to @sub_question, notice: 'Sub-Question was successfully updated.'
    else
      flash.now[:alert] = 'Sub-Question was not updated.'
      render action: "edit"
    end
  end

  # DELETE /sub_questions/1
  def destroy
    @sub_question = SubQuestion.find(params[:id])
    if @sub_question.destroy
      redirect_to diagnostic_admin_path(@sub_question.question.segment.diagnostic.id), notice: 'Question was successfully deleted.'
    else
      redirect_to diagnostic_admin_path(@sub_question.question.segment.diagnostic.id), alert: 'Question was not deleted.'
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