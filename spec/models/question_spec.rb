require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of :question_type }
  it { is_expected.to validate_presence_of :question }
  it { should validate_inclusion_of(:question_type).in_array(VALID_QUESTION_TYPE.keys)}

  before :each do
    @answers_attributes = [{
      answer: "Answer Test 1",
      is_correct: true
    },{
      answer: "Answer Test 2",
      is_correct: false
    }]
  end

  context "when try to save question" do
    it "should run a question field validation" do
      invalid_question = Question.create(
        question_type: 1,
        answers_attributes: @answers_attributes
      )

      errors = {:question=>["can't be blank"]}

      expect(invalid_question.errors.messages).to eq errors
    end

    it "should run a question_type field validation" do
      invalid_question = Question.create(
        question: "Dummy Question 1",
        answers_attributes: @answers_attributes
      )

      errors = {:question_type=>["can't be blank", "is not included in the list"]}

      expect(invalid_question.errors.messages).to eq errors
    end

    it "should run a answers validation (Single option)" do
      invalid_question = Question.create(
        question: "Dummy Question 1",
        question_type: 1,
        answers_attributes: []
      )

      errors = { :base => [
        "A Question should at least have 2 possible answers",
        "Question with type 'Single option' only be able to have one correct answer"
      ]}

      expect(invalid_question.errors.messages).to eq errors
    end

    it "should run a answers validation (Multiple option)" do
      invalid_question = Question.create(
        question: "Dummy Question 1",
        question_type: 2,
        answers_attributes: []
      )

      errors = { :base => [
        "A Question should at least have 2 possible answers",
        "Question with type 'Multiple options' should at least have one correct answer"
      ]}

      expect(invalid_question.errors.messages).to eq errors
    end
  end

  context "when save question with a valid data" do
    it "should be able to store a question with question type is Single option" do
      question = Question.create(
        question: "Dummy Question 1",
        question_type: 1,
        answers_attributes: @answers_attributes
      )

      expect(question.answers.count).to eq 2
    end

    it "should be able to store a question with question type is Multiple options" do
      @answers_attributes << {
        answer: "Answer Test 3",
        is_correct: true
      }

      question = Question.create(
        question: "Dummy Question 1",
        question_type: 2,
        answers_attributes: @answers_attributes
      )

      expect(question.answers.count).to eq 3
    end

    it "should get correct answers" do
      question = Question.create(
        question: "Dummy Question 1",
        question_type: 1,
        answers_attributes: @answers_attributes
      )

      expect(question.correct_answers.count).to eq 1

      @answers_attributes << {
        answer: "Answer Test 3",
        is_correct: true
      }

      question = Question.create(
        question: "Dummy Question 1",
        question_type: 2,
        answers_attributes: @answers_attributes
      )

      expect(question.correct_answers.count).to eq 2
    end
  end
end
