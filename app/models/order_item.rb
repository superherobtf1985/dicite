class OrderItem < ApplicationRecord
  belongs_to :order, dependent: :destroy
  belongs_to :item, dependent: :destroy

  attachment :jacket_image

  validates :item_name, presence: true
  validates :price, presence: true
  validates :item_count, presence: true
end
