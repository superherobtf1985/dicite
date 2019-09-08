class Contact < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :contacts, presence: true
end
