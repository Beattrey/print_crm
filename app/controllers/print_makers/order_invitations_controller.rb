module PrintMakers
  class OrderInvitationsController < ApplicationController
    before_action :find_data

    def accept
      @order_inivitation.accept!
      redirect_to print_makers_order_path(@order), notice: 'Ви прийняли запрошення'
    end

    def reject
      @order_inivitation.reject!
      redirect_to available_orders_print_makers_orders_path, alert: 'Ви відхилили запрошення'
    end

    private

    def find_data
      @order_inivitation = OrderInvitation.find_by(print_maker_id: current_user.id, order_id: params[:id])
      @order = Order.find(params[:id])
    end
  end
end
