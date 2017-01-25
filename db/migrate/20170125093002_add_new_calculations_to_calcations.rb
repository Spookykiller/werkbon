class AddNewCalculationsToCalcations < ActiveRecord::Migration
  def change
    add_column :calculations, :uitlijnen_met, :string
    add_column :calculations, :tuimelkoord, :boolean
    add_column :calculations, :raam_prijs, :decimal
    add_column :calculations, :ondergrond, :string
    add_column :calculations, :voorstrijken, :boolean
  end
end
