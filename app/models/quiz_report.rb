class QuizReport < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  enum status: { waiting: 0, pending: 1, finished: 2 }
end
