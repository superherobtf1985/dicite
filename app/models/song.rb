class Song < ApplicationRecord
  belongs_to :cd

  validates :name, presence: true
  validates :number, presence: true
end
