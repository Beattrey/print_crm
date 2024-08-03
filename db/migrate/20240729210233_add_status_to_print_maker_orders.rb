class AddStatusToPrintMakerOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :print_maker_orders, :status, :string, default: 'pending'
  end
end
