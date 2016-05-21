class Question < ActiveRecord::Base
  # has many
  has_many :answers, dependent: :destroy

  # validation
  validates :question_type,
    presence: true,
    inclusion: { in: VALID_QUESTION_TYPE.keys }

  validates :question, presence: true

  after_save :validate_answers

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  private

  def validate_answers
    flag = true

    if self.answers.size < 2
      errors.add(:base, "A Question should at least have 2 possible answers")
      flag = false
    end

    count = 0
    self.answers.map{|a| count += 1 if a.is_correct }

    case self.question_type
    when 1
      if count > 1 || count == 0
        errors.add(:base, "Question with type '#{VALID_QUESTION_TYPE[1]}' only be able to have one correct answer")
        flag = false
      end
    when 2
      if count == 0
        errors.add(:base, "Question with type '#{VALID_QUESTION_TYPE[2]}' should at least have one correct answer")
        flag = false
      end
    end

    if !flag
      raise ActiveRecord::Rollback, "Failed to save records"
    end

    flag
  end
end
