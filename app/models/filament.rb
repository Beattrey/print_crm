class Filament < ApplicationRecord
  has_many :profiles_filaments
  has_many :profiles, through: :profiles_filaments

  enum name: { pla: 'pla', abs: 'abs', petg: 'petg', tpu: 'tpu'}
end
