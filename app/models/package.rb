class Package < ApplicationRecord
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
end
