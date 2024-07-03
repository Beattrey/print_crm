class OrderInvitation < ActiveRecord::Migration[7.0]
  def change
    create_table :order_invitations do |t|
      t.string :status

      t.references :filament, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.timestamps
    end
  end
end
