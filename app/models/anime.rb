class Anime < ApplicationRecord
  has_many :quizzes
  has_many :packages

  validates :title, presence: true, uniqueness: true

  enum status: { published: 0, deleted: 1 }

  class << self
    def having_quiz_collection
      joins(:quizzes)
        .where(quizzes: { status: :published })
        .order(id: :asc)
        .distinct
        .pluck(:title, :id)
    end

    def having_ranking_collection
      joins(:packages)
        .where.not(packages: { ranking_score: nil })
        .order(id: :asc)
        .distinct
        .pluck(:title, :id)
    end
  end
end
