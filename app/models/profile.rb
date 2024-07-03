class Profile < ApplicationRecord
  enum rank: { newbie: 'newbie', pro: 'pro', expert: 'expert', guru: 'guru' }

  has_many :profiles_filaments
  has_many :filaments, through: :profiles_filaments
end
