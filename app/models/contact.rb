class Contact < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :item, dependent: :destroy

  validates :contacts, presence: true
end
