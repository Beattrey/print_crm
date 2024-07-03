class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :rank
      t.string :screen_name

      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
