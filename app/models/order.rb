class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :shippings

  enum how_to_pay: { cash: 0, transfer: 1 }
end
