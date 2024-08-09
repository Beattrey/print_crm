class AddOrderableToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :orderable, polymorphic: true, index: true
  end
end
