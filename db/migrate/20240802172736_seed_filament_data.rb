class SeedFilamentData < ActiveRecord::Migration[7.0]
  def up
    Filament.names.values.each { |a| Filament.create(name: a) }
  end

  def down
    Filament.where(name: Filament.names.values).destroy_all
  end
end
