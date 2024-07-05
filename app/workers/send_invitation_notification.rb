class SendInvitationNotification
  include Sidekiq::Worker

  def perform(order_invitation_id)
    order_invitation = OrderInvitation.find(order_invitation_id)
    return unless order_invitation

    # send notification to user
  end
end
