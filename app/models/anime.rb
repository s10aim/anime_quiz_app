class Anime < ApplicationRecord
  has_many :quizzes
  has_many :packages

  validates :title, presence: true, uniqueness: true
end
