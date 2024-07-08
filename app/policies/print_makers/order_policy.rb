module PrintMakers
  class OrderPolicy < ApplicationPolicy
    def can_see_invite_section?
      return true if @record.order_invitations.where(print_maker_id: @user.id, status: 'pending').present?

      false
    end

    def invitation_accepted?
      return true if @record.order_invitations.where(print_maker_id: @user.id, status: 'accepted').present?

      false
    end
  end
end
