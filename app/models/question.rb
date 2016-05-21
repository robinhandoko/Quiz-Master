class Question < ActiveRecord::Base
  # has many
  has_many :answers

  # validation
  validates :question_type,
    inclusion: { in: VALID_QUESTION_TYPE.keys },
    presence: true

  validates :question, presence: true

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
end
