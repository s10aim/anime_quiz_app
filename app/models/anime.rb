class Anime < ApplicationRecord
  has_many :quizzes

  validates :title, presence: true, uniqueness: true
end
