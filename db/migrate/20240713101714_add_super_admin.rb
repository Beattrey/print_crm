class AddSuperAdmin < ActiveRecord::Migration[7.0]
  def change
    create_table :super_admins do |t|
      t.references :worker, null: false, foreign_key: true
      t.timestamps
    end
  end
end
