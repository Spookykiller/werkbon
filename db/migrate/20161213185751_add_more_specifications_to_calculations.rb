class AddMoreSpecificationsToCalculations < ActiveRecord::Migration
  def change
    remove_column :calculations, :bocht
    add_column :calculations, :knipmaat, :string
    add_column :calculations, :bocht_type, :string
    add_column :calculations, :bocht_maat, :string
    add_column :calculations, :snijmaat, :string
    add_column :calculations, :ondervloer, :string
    add_column :calculations, :legrichting, :string
  end
end
