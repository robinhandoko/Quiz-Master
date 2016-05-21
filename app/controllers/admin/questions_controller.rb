class Admin::QuestionsController < AdminController
  before_action :prepare_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.page(params[:page] || 1)
  end

  def show
  end

  def new
    @question = Question.new(question_type: VALID_QUESTION_TYPE.keys.first)
    @question.answers.build
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to admin_questions_path, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to admin_questions_path, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_questions_path, notice: 'Question was successfully destroyed.'
  end

  private
    def prepare_question
      @question = Question.find_by_id(params[:id])
      if @question.blank?
        redirect_to admin_questions_path, notice: "Question not found."
      end
    end

    def question_params
      params.require(:question).permit(:question, :question_type,
        :answers_attributes => [:id, :answer, :is_correct, :_destroy]
      )
    end
end
