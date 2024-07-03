class CreateFilaments < ActiveRecord::Migration[7.0]
  def change
    create_table :filaments do |t|
      t.string :name

      t.timestamps
    end
  end
end
