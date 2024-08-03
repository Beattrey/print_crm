class AddPrintMakerAdmin < ActiveRecord::Migration[7.0]
  def change
    create_table :print_maker_admins do |t|
      t.references :worker, null: false, foreign_key: true
      t.timestamps
    end
  end
end
