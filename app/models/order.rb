class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :shippings

  enum how_to_pay: { cash: 0, transfer: 1 }

  validates :how_to_pay, presence: true
  validates :first_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :first_kana_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :last_kana_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :phone, presence: true, format: /\A\d{10,11}\z/
  validates :postal_code, presence: true, format: /\A\d{7}\z/
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :building, presence: true

end
