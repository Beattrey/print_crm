class CreateOrderFilaments < ActiveRecord::Migration[7.0]
  def change
    create_table :order_filaments do |t|
      t.references :order, null: false, foreign_key: true
      t.references :filament, null: false, foreign_key: true

      t.timestamps
    end
  end
end
