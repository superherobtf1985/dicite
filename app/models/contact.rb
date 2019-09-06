class Contact < ApplicationRecord
  belongs_to :user

  validates :contacts ,presence: true
end
