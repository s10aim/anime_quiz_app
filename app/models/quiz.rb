class Quiz < ApplicationRecord
  belongs_to :user
  belongs_to :anime

  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices

  validates :question, presence: true
end
