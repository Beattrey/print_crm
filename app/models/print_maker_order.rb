class PrintMakerOrder < ApplicationRecord
  belongs_to :print_maker
  belongs_to :order
  has_many_attached :images, dependent: :purge

  enum status: { pending: 'pending', in_progress: 'in_progress', completed: 'completed' }

  def available_completed_quantity
    reserved_quantity
  end
end
