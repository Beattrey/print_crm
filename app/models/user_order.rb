class UserOrder < ApplicationRecord
  belongs_to :user
  belongs_to :order
  has_many_attached :images, dependent: :purge
end
