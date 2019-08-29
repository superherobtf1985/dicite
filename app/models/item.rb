class Item < ApplicationRecord
  belongs_to :artist
  belongs_to :genre
  belongs_to :label
  attachment :jacket_image

  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true
  validates :genre_id, presence: true
  validates :artist_id, presence: true
  validates :label_id, presence: true

end
