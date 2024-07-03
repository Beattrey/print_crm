class CreateProfilesFilaments < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles_filaments, id: false do |t|
      t.belongs_to :profile, null: false, foreign_key: true, index: true
      t.belongs_to :filament, null: false, foreign_key: true, index: true
    end
  end
end
