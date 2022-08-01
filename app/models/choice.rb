class Choice < ApplicationRecord
  belongs_to :quiz

  has_many :quiz_packages

  validates :body, presence: true, uniqueness: { scope: :quiz_id }
  before_validation :remove_space_from_choices

  def remove_space_from_choices
    self.body = body.gsub(/[[:space:]]/, '')
  end
end
