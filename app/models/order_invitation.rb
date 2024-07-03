class OrderInvitation < ApplicationRecord
  belongs_to :order
  belongs_to :user
  belongs_to :filament

  enum status: { pending: 0, accepted: 1, rejected: 2 }
end
