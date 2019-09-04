class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  attachment :jacket_image
end
