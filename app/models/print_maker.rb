class PrintMaker < ApplicationRecord

  belongs_to :worker

  has_many :print_makers_filaments, dependent: :destroy
  has_many :filaments, through: :print_makers_filaments
  has_many :order_invitations, dependent: :destroy
  has_many :print_maker_orders, dependent: :destroy
  has_many :orders, through: :print_maker_orders

  enum status: { ready: 'Готовий', busy: 'Зайнятий', cant_take_orders: 'Не можу працювати' }
  enum rank: { newbie: 'newbie', pro: 'pro', expert: 'expert', guru: 'guru' }
end
