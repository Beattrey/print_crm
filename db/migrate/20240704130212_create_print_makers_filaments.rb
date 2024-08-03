class CreatePrintMakersFilaments < ActiveRecord::Migration[7.0]
  def change
    create_table :print_makers_filaments do |t|
      t.belongs_to :print_maker, null: false, foreign_key: true, index: true
      t.belongs_to :filament, null: false, foreign_key: true, index: true
    end
  end
end
