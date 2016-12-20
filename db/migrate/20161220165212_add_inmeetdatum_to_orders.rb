class AddInmeetdatumToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :inmeetdatum, :string
  end
end
