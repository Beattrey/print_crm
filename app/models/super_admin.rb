class SuperAdmin < ApplicationRecord
  belongs_to :worker

  def account_type
    'super_admin'
  end
end
