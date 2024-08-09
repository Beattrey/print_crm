class SuperAdmin < ApplicationRecord
  belongs_to :worker
  has_many :orders, as: :orderable

  def account_type
    'super_admin'
  end
end
