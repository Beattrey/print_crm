class PrintMakerAdmin < ApplicationRecord
  belongs_to :worker
  has_many :orders, as: :orderable

  def account_type
    'print_maker_admin'
  end
end
