class QuizController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.page(params[:page]).per(1)
  end
end
