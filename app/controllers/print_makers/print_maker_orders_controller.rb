module PrintMakers
  class PrintMakerOrdersController < ApplicationController
    before_action :find_data

    def update
      if @print_maker_order.update(print_maker_order_params)
        redirect_to print_makers_order_path(@order), notice: 'Замовлення було успішно оновлено.'
      end
    end

    def close_order
      @print_maker_order.update(status: "completed")
      redirect_to available_orders_print_makers_orders_path, notice: "Замовлення успішно закрито."
    end

    private

    def find_data
      @order = Order.find(params[:id])
      @print_maker_order = PrintMakerOrder.find_by(print_maker_id: current_user.id, order_id: @order.id)
    end

    def print_maker_order_params
      params.require(:print_maker_order).permit(
        :reserved_quantity,
        :completed_quantity,
        images: [],
        )
    end
  end
end
