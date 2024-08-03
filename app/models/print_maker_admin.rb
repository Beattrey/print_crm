class PrintMakerAdmin < ApplicationRecord
  belongs_to :worker

  def account_type
    'print_maker_admin'
  end
end
