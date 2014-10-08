class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = @question

    if @answer.save
      MyMailer.delay.answer_notification(@answer)
      redirect_to question_path(@question), notice: "Answer was successfully created."
    else
      redirect_to question_path(@question), alert: "There was an error when adding answer."
    end
  end

  def change_like
    @answer = Answer.find(params[:answer_id])
    user = @answer.user
    @like = AnswerLike.new
    @like.answer_id = @answer.id
    @like.user_id = current_user.id
    if @like.save
      user.points +=5
      user.save
      #redirect_to question_path(@question)
    end
  end

  def accept
    @answer = Answer.find(params[:answer_id])
    user = @answer.user
    @answer_to_deactivate = Answer.where(:question_id=>params[:question_id], :accept=>true).first
    user_deactivate = @answer_to_deactivate.user unless @answer_to_deactivate.nil?
    if @answer.accept == false
      unless @answer_to_deactivate.nil?
        @answer_to_deactivate.accept = false 
        @answer_to_deactivate.save 
        user_deactivate.points -=25
        user_deactivate.save
      end
      MyMailer.delay.accepted_answer_notification(@answer)
      @answer.accept = true
      @answer.save
      user.points +=25
      user.save
    end  
  redirect_to question_path(@question)
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:contents)
    end
end
