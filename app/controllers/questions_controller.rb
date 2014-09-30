class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.page(params[:page]).per(10)
  end

  def show
    @answer = Answer.new
    @answers = @question.answers.page(params[:page]).per(5)
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    user = current_user
    if user.points - 10 >= 0 
      if @question.save
        user.points -=10
        user.save
        redirect_to @question, notice: 'Question was successfully created.'
      else
        render :new
      end
    else
      flash[:error] = "You haven't enough points to create a question"
      redirect_to @question
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :contents)
    end
end
