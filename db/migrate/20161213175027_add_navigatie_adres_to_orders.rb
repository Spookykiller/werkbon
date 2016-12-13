class AddNavigatieAdresToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :navigatie_adres, :string
  end
end
