class Quiz < ApplicationRecord
  CORRECT_CHOICE_LIMIT = 1

  belongs_to :user
  belongs_to :anime

  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices

  has_many :quiz_packages
  has_many :packages, through: :quiz_packages

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_many :quiz_reports

  validates :question, presence: true
  before_validation :choices_body_is_uniqueness
  before_validation :correct_choice_is_only_one

  before_save :set_published_at

  enum status: { published: 0, draft: 1, deleted: 2 }

  # MEMO: 選択肢をスワップするような更新が走ると, ユニークバリデーションに引っかかってしまう
  # 事前に選択肢をデタラメに更新しておき, ユニークバリデーションエラーの発生を回避
  def update_with_avoiding_uniqueness_error(quiz_params)
    success = false
    transaction do
      choices.each do |choice|
        choice.update_columns(body: SecureRandom.uuid)
      end
      success = update(quiz_params)

      raise ActiveRecord::Rollback unless success
    end
    success
  end

  scope :lists_of, lambda { |user, target|
    where(user_id: user.id).where(status: target)
  }

  def liked_by?(user)
    likes.any? { |like| like.user_id == user.id }
  end

  class << self
    def answer_count_map
      joins(:quiz_packages)
        .where.not(quiz_packages: { choice_id: nil })
        .group("#{table_name}.id")
        .count
    end

    def correct_answer_count_map
      joins(quiz_packages: :choice)
        .where(quiz_packages: { choices: { is_correct: true } })
        .group("#{table_name}.id")
        .count
    end
  end

  private

  def choices_body_is_uniqueness
    choice_target = choices.map do |choice|
      choice.remove_space_from_choices
      choice.body
    end
    return if choice_target.uniq.count == choice_target.count

    errors.add(:choices, :duplicate)
  end

  def correct_choice_is_only_one
    if choices.map(&:is_correct).count(true).zero?
      errors.add(:choices, :not_exist)
    elsif choices.map(&:is_correct).count(true) > CORRECT_CHOICE_LIMIT
      errors.add(:choices, :many_exist)
    end
  end

  def set_published_at
    return if published_at.present?
    return if draft?

    update(published_at: Time.zone.now)
  end
end
