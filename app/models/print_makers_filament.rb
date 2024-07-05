class PrintMakersFilament < ApplicationRecord
  belongs_to :print_maker
  belongs_to :filament
end
