class ChangeOrderStatesId < ActiveRecord::Migration
  def change
    rename_column :vloers, :order_states_id, :order_state_id
  end
end
