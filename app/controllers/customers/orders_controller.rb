module Customers
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_customer!

    def index
      @orders = current_user.customer.orders
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      @order = Order.new
    end

    def create
      @order = Order.new(order_params.merge(customer_id: current_user.customer.id))

      if @order.save
        redirect_to customers_orders_path, notice: 'Замовлення створено'
      end
    end


    private

    def ensure_customer!
      redirect_to root_path, alert: "Access denied!" unless current_user.customer
    end

    def order_params
      params.require(:order).permit(
        :name,
        :description,
        :quantity,
        :deadline,
        :customer_id,
        :filament_id,
        images: [],
        models: []
      )
    end
  end
end
