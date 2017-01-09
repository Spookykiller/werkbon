class RemoveAndAddOrderRelation < ActiveRecord::Migration
  def change
    remove_column :vloers, :order_id
    add_reference :vloers, :order_states, index: true
  end
end
