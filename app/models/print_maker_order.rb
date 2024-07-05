class PrintMakerOrder < ApplicationRecord
  belongs_to :print_maker
  belongs_to :order
  has_many_attached :images, dependent: :purge
end
