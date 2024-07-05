class Filament < ApplicationRecord
  has_many :profiles_filaments
  has_many :profiles, through: :profiles_filaments

  enum name: { pla: 'PLA', abs: 'ABS', petg: 'PETG', tpu: 'TPU'}
end
