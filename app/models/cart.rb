class Cart < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :count, presence: true, length: { minimum: 1 }
end
