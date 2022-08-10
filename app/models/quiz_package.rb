class QuizPackage < ApplicationRecord
  belongs_to :quiz
  belongs_to :choice, optional: true
  belongs_to :package

  validates :position, presence: true, uniqueness: { scope: :package_id }
end
