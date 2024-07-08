class PrintMakerOrder < ApplicationRecord
  belongs_to :print_maker
  belongs_to :order
  has_many_attached :images, dependent: :purge

  def available_completed_quantity
    return reserved_quantity if completed_quantity.nil?

    reserved_quantity - completed_quantity
  end
end
