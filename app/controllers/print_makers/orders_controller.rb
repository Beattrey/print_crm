module PrintMakers
  class OrdersController < ApplicationController
    def index
      @orders = current_user.print_maker.orders
    end

    def show
      @order = Order.find(params[:id])
      @print_maker_order = PrintMakerOrder.not_finished.find_or_create_by(print_maker_id: current_user.print_maker.id, order_id: @order.id)
      @available_quantity = @order.available_quantity
    end

    def available_orders
      @available_orders = Order.available_orders
    end

    def archived_orders
      @archived_orders = PrintMakerOrder.completed.where(print_maker_id: current_user.print_maker.id)
    end
  end
end
