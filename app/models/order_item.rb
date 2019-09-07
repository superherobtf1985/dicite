class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  attachment :jacket_image

  validates :item_name, presence: true
  validates :price, presence: true
  validates :item_count, presence: true
end
