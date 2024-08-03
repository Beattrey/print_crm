class PrintMakerOrder < ApplicationRecord
  belongs_to :print_maker
  belongs_to :order

  enum status: { pending: 'pending', in_progress: 'in_progress', completed: 'completed' }

  scope :not_finished, -> { where.not(status: 'completed') }
  scope :completed, -> { where(status: 'completed') }

  def available_completed_quantity
    reserved_quantity
  end
end
