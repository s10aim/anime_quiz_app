class Anime < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
