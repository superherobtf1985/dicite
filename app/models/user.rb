class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites
  has_many :reviews
  has_many :carts
  has_many :shippings
  has_many :orders
  has_many :contacts

  validates :first_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :last_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :first_kana_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :last_kana_name, presence: true, length: { maximum: 20, minmum: 2 }
  validates :phone, presence: true, format: /\A\d{10,11}\z/
  validates :postal_code, presence: true, format: /\A\d{7}\z/
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :building, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
end
