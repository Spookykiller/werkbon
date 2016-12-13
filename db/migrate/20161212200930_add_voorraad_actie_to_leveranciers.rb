class AddVoorraadActieToLeveranciers < ActiveRecord::Migration
  def change
    add_column :leveranciers, :voorraad_actie, :string
  end
end
