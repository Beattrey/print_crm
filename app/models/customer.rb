class Customer < ApplicationRecord
  belongs_to :worker
  has_many :orders, as: :orderable, dependent: :destroy

  def account_type
    'customer'
  end
end
