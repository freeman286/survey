class SubQuestionsController < ApplicationController
  # GET /sub_questions
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :yes, :no]
  before_filter :can_edit, only: [:new, :create, :edit, :update, :destroy]

  def index
    @sub_questions = SubQuestion.all
  end

  # GET /sub_questions/1
  def show
    @sub_question = SubQuestion.find(params[:id])
    @crud_state = "show"
  end

  # GET /sub_questions/new
  def new
    @sub_question = SubQuestion.new(question_id: params[:question_id])
    @crud_state = "new"
  end

  # GET /sub_questions/1/edit
  def edit
    @sub_question = SubQuestion.find(params[:id])
    @crud_state = "edit"
  end

  # POST /sub_questions
  def create
    @sub_question = SubQuestion.new(params[:sub_question])
    @crud_state = "create"

    if @sub_question.save
      redirect_to diagnostic_admin_path(@sub_question.question.segment.diagnostic.id), notice: 'Sub-Question was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /sub_questions/1
  def update
    @sub_question = SubQuestion.find(params[:id])
    @crud_state = "update"

    if @sub_question.update_attributes(params[:sub_question])
      redirect_to diagnostic_admin_path(@sub_question.question.segment.diagnostic), notice: 'Sub-Question was successfully updated.'
    else
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

  def select
    @sub_question = SubQuestion.find(params[:sub_question_id])
    @answer = Answer.find_or_create_by_user_id_and_sub_question_id(current_user.id, @sub_question.id)
    @answer.toggle!(current_user)
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
