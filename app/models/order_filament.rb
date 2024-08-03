class OrderFilament < ApplicationRecord
  belongs_to :order
  belongs_to :filament
end
