class AddKoofRaammontageToCalculations < ActiveRecord::Migration
  def change
    add_column :calculations, :koof, :string
    add_column :calculations, :raam_montage, :string
  end
end
