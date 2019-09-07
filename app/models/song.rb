class Song < ApplicationRecord
  belongs_to :cd, dependent: :destroy

  validates :name, presence: true
  validates :number, presence: true
end
