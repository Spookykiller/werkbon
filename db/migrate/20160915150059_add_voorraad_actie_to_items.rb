class AddVoorraadActieToItems < ActiveRecord::Migration
  def change
    add_column :items, :voorraad_actie, :string
  end
end
