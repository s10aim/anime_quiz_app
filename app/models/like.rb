class Like < ApplicationRecord
  belongs_to :quiz
  belongs_to :user

  validates :user_id, uniqueness: {
    scope: :quiz_id,
    message: :too_many_likes
  }
end
