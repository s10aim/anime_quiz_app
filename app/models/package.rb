class Package < ApplicationRecord
  RANKING_LIMIT = 10

  belongs_to :user, optional: true
  belongs_to :anime, optional: true

  has_many :quiz_packages
  has_many :quizzes, through: :quiz_packages

  before_validation :select_anime

  enum category: { complete: 0, selected: 1 }

  def select_anime
    return if category == 'complete'

    errors.add(:anime_id, :not_selected_anime) if anime_id.nil?
  end

  scope :ranking_of, lambda { |range|
    where.not(ranking_score: nil)
         .where.not(user_id: nil)
         .where(finished_at: range)
         .where(category: 'complete')
  }

  scope :my_best_score_of, lambda { |user, category|
    where(user_id: user.id)
      .where.not(ranking_score: nil)
      .order(ranking_score: :desc)
      .where(category:)
      .first
  }

  scope :ordered, -> { order(ranking_score: :desc, finished_at: :asc) }

  class << self
    def complete_best_ranking(user)
      ranking = ranking_of(Date.parse('2022/07/01')..Time.zone.now)
                .order(ranking_score: :desc, finished_at: :asc).index do |package|
        package.user_id == user.id
      end

      ranking.nil? ? nil : ranking + 1
    end

    def selected_best_ranking(user)
      ranking = anime_ranking.index do |package|
        package.user_id == user.id
      end

      ranking.nil? ? nil : ranking + 1
    end

    def week_ranking
      ranking_of(Time.zone.now.all_week)
        .includes(:user)
        .ordered
        .limit(RANKING_LIMIT)
    end

    def month_ranking
      ranking_of(Time.zone.now.all_month)
        .includes(:user)
        .ordered
        .limit(RANKING_LIMIT)
    end

    def anime_ranking
      where.not(ranking_score: nil)
           .where.not(user_id: nil)
           .where(category: 'selected')
           .includes(:user, :anime)
           .ordered
    end

    def selected_anime_ranking(anime_id)
      where.not(ranking_score: nil)
           .where.not(user_id: nil)
           .where(anime_id:)
           .includes(:user, :anime)
           .ordered
           .limit(RANKING_LIMIT)
    end
  end
end
