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

    def can_see_attached_model?
      order_filaments = @record.order_filaments.pluck(:filament_id)
      print_makers_filaments = @user.print_makers_filaments.pluck(:filament_id)

      order_filaments.all? { |element| print_makers_filaments.include?(element) }
    end
  end
end
