class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order

  validates :first_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :last_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :first_kana_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :last_kana_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :phone, presence: true, format: /\A\d{10,11}\z/
  validates :postal_code, presence: true, format: /\A\d{7}\z/
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :building, presence: true
end
