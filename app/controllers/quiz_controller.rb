class QuizController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.page(params[:page]).per(1)
  end

  def submit_answer
    correct_answer = false
    question = Question.find_by_id(params[:id])

    if question.blank?
      @result = @result = {
        correct_answer: correct_answer,
        message: "Question not found or invalid"
      }
    else
      selected_answer = Answer.where(id: params[:selected_answer])
      if selected_answer == question.corrent_answers
        correct_answer = true
      end

      message = "Answer by #{current_user.email} on Quiz mode: #{selected_answer.pluck(:answer).join(', ')}"

      @result = {
        correct_answer: correct_answer,
        message: message
      }
    end
  end
end
