class Package < ApplicationRecord
  belongs_to :user, optional: true
end
