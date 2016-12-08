class AddRegelIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :ref_id, :integer
  end
end
