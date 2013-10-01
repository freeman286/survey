class QuestionsController < ApplicationController
  # GET /questions
  
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    end
  end

  # GET /questions/new
  def new
    @question = Question.new(:segment_id => params[:segment_id])
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])

    if @question.save
      redirect_to diagnostic_admin_path(@question.segment.diagnostic.id), notice: 'Question was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /questions/1
  def update
    @question = Question.find(params[:id])

      if @question.update_attributes(params[:question])
        redirect_to @question, notice: 'Question was successfully updated.'
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
end
