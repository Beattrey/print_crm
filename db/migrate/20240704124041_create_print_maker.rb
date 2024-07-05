class CreatePrintMaker < ActiveRecord::Migration[7.0]
  def change
    create_table :print_makers do |t|
      t.string :status
      t.string :rank
      t.references :worker, null: false, foreign_key: true
      t.timestamps
    end
  end
end
