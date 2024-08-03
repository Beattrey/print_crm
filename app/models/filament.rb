class Filament < ApplicationRecord
  has_many :profiles_filaments
  has_many :profiles, through: :profiles_filaments
  has_many :order_filaments, dependent: :destroy
  has_many :orders, through: :order_filaments

  enum name: { pla: 'PLA', abs: 'ABS', petg: 'PETG', tpu: 'TPU'}
end
