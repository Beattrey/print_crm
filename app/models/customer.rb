class Customer < ApplicationRecord
  has_one :worker, dependent: :destroy
  has_many :orders, dependent: :destroy
end
