class Package < ApplicationRecord
  belongs_to :user, optional: true

  has_many :quiz_packages

  enum category: { complete: 0, selected: 1 }
end
