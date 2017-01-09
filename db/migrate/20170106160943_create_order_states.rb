class CreateOrderStates < ActiveRecord::Migration
  def change
    create_table :order_states do |t|
      t.references :order, index: true, foreign_key: true
      t.integer :status

      t.timestamps null: false
    end
  end
end
