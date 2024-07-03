class UserOrder < ActiveRecord::Migration[7.0]
  def change
    create_table :user_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
