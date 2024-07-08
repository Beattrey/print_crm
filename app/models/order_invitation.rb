class OrderInvitation < ApplicationRecord
  belongs_to :order
  belongs_to :print_maker

  enum status: { pending: 'pending', accepted: 'accepted', rejected: 'rejected' }

  before_create :set_initial_status
  after_create :send_invitation_notification

  def accept!
    update(status: 'accepted')
  end

  def reject!
    update(status: 'rejected')
  end

  private

  def set_initial_status
    self.status ||= 'pending'
  end

  def send_invitation_notification
    SendInvitationNotification.perform_async(id)
  end
end
