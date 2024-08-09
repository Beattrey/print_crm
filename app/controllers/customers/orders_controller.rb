module Customers
  class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_customer!

    def index
      @orders = current_user.customer&.orders || current_user.print_maker_admin&.orders || current_user.super_admin&.orders
    end

    def show
      @order = Order.find(params[:id])
    end

    def new
      @order = Order.new
    end

    def create
      @order = Order.new(order_params)
      @order.orderable = current_user.customer || current_user.print_maker_admin || current_user.super_admin

      if @order.save
        redirect_to customers_orders_path, notice: 'Замовлення створено'
      end
    end

    def edit
      @order = Order.find(params[:id])
    end

    def update
      @order = Order.find(params[:id])

      params[:order][:images].select(&:present?).each do |image|
        @order.images.attach(image)
      end

      params[:order][:models].select(&:present?).each do |model|
        @order.models.attach(model)
      end

      if @order.update(order_params.except(:models, :images))
        redirect_to customers_orders_path, notice: 'Замовлення оновлено'
      end
    end

    def remove_image
      image = ActiveStorage::Attachment.find(params[:image_id])
      image.purge
      redirect_back(fallback_location: root_path, notice: 'Зображення видалено.')
    end

    def remove_model
      @order = Order.find(params[:id])
      model = @order.models.find(params[:model_id])
      model.purge
      redirect_to edit_customers_order_path(@order), notice: 'Модель було успішно видалено.'
    end

    private

    def ensure_customer!
      return if current_user.customer || current_user.print_maker_admin || current_user.super_admin

      redirect_to root_path, alert: "Access denied!"
    end

    def order_params
      clear_empty_values

      params.require(:order).permit(
        :name,
        :description,
        :quantity,
        :deadline,
        :customer_id,
        filament_ids: [],
        images: [],
        models: []
      )
    end

    def clear_empty_values
      params['order']['filament_ids'].reject!(&:blank?)
    end
  end
end
