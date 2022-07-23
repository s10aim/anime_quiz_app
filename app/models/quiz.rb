class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  has_one :choice, dependent: :destroy

  validates :question, presence: true
end
