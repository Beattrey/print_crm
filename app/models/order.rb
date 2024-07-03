class Order < ApplicationRecord
  has_many_attached :images, dependent: :purge
  has_many_attached :models, dependent: :purge
  has_many :user_orders, dependent: :destroy
  has_many :users, through: :user_orders
  has_may :order_invitations, dependent: :destroy
end
