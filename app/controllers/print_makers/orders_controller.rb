module PrintMakers
  class OrdersController < ApplicationController
    def index
      @orders = current_user.print_maker.orders
    end

    def show
      @order = Order.find(params[:id])
      @print_maker_order = PrintMakerOrder.find_or_create_by(print_maker_id: current_user.id, order_id: @order.id)
      @available_quantity = @order.quantity - PrintMakerOrder.where(order_id: @order.id).sum(&:reserved_quantity) # maybe should be recalculated after logic with closed order will be done
    end

    def available_orders
      @available_orders = current_user.print_maker.available_orders
    end
  end
end
