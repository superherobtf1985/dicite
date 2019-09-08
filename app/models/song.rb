class Song < ApplicationRecord
  belongs_to :cd

  validates :name, presence: true
end
