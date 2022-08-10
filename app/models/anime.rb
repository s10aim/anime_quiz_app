class Anime < ApplicationRecord
  has_many :quizzes
  has_many :packages

  validates :title, presence: true, uniqueness: true

  class << self
    def select_animes_collection
      joins(:quizzes)
        .where(quizzes: { status: :published })
        .order(id: :asc)
        .distinct
        .pluck(:title, :id)
    end
  end
end
