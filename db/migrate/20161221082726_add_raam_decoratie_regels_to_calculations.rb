class AddRaamDecoratieRegelsToCalculations < ActiveRecord::Migration
  def change
    add_column :calculations, :pakket, :string
    add_column :calculations, :zijgeleiding, :string
    add_column :calculations, :contra_rolend, :string
  end
end
