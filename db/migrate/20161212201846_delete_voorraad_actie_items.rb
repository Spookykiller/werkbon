class DeleteVoorraadActieItems < ActiveRecord::Migration
  def change
    remove_column :items, :voorraad_actie
  end
end
