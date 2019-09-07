class Cart < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :count, presence: true, length: { minimum: 1 }
end
