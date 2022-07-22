class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  validates :question, presence: true
end
