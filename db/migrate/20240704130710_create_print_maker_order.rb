class CreatePrintMakerOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :print_maker_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :print_maker, null: false, foreign_key: true
      t.integer :reserved_quantity
      t.integer :completed_quantity
      t.timestamps
    end
  end
end
