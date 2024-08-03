class AddTrackNumberToPrintMakerOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :print_maker_orders, :track_number, :string
  end
end
