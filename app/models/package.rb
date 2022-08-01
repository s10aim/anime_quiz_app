class Package < ApplicationRecord
  belongs_to :user, optional: true

  enum category: { complete: 0, selected: 1 }
end
