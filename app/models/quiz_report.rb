class QuizReport < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  validates :reason, presence: true, length: { maximum: 500 }

  enum status: { waiting: 0, pending: 1, finished: 2 }
end
