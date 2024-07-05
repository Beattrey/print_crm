class OrderInvitation < ApplicationRecord
  belongs_to :order
  belongs_to :print_maker

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  after_create :send_invitation_notification

  private

  def send_invitation_notification
    SendInvitationNotification.perform_async(id)
  end
end
