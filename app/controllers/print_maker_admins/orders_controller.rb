module PrintMakerAdmins
  class OrdersController < ApplicationController
    before_action :find_data, only: %i[reject_order approve_order show]

    def index
      @orders = Order.all
    end

    def show
      @order
    end

    def reject_order
      return unless @order.rejected!

      redirect_to print_maker_admins_orders_path, notice: 'Ви вiдхилили замовлення'
    end

    def approve_order
      return unless @order.approved!

      redirect_to print_maker_admins_orders_path, notice: 'Ви прийняли замовлення'
    end

    private

    def find_data
      @order = Order.find(params[:id])
    end
  end
end
