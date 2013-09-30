class SubQuestionsController < ApplicationController
  # GET /sub_questions
  # GET /sub_questions.json
  def index
    @sub_questions = SubQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sub_questions }
    end
  end

  # GET /sub_questions/1
  # GET /sub_questions/1.json
  def show
    @sub_question = SubQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sub_question }
    end
  end

  # GET /sub_questions/new
  # GET /sub_questions/new.json
  def new
    @sub_question = SubQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sub_question }
    end
  end

  # GET /sub_questions/1/edit
  def edit
    @sub_question = SubQuestion.find(params[:id])
  end

  # POST /sub_questions
  # POST /sub_questions.json
  def create
    @sub_question = SubQuestion.new(params[:sub_question])

    respond_to do |format|
      if @sub_question.save
        format.html { redirect_to @sub_question, notice: 'Sub question was successfully created.' }
        format.json { render json: @sub_question, status: :created, location: @sub_question }
      else
        format.html { render action: "new" }
        format.json { render json: @sub_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sub_questions/1
  # PUT /sub_questions/1.json
  def update
    @sub_question = SubQuestion.find(params[:id])

    respond_to do |format|
      if @sub_question.update_attributes(params[:sub_question])
        format.html { redirect_to @sub_question, notice: 'Sub question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sub_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_questions/1
  # DELETE /sub_questions/1.json
  def destroy
    @sub_question = SubQuestion.find(params[:id])
    @sub_question.destroy

    respond_to do |format|
      format.html { redirect_to sub_questions_url }
      format.json { head :no_content }
    end
  end
end
