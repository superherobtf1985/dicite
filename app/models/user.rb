class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites
  has_many :reviews
  has_many :carts
  has_many :shippings
  has_many :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_kana_name, presence: true
  validates :last_kana_name, presence: true
  validates :phone, presence: true, format: /\A\d{10,11}\z/
  validates :postal_code, presence: true, format: /\A\d{7}\z/
  validates :prefecture, presence: true
end
