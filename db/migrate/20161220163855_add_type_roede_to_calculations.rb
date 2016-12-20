class AddTypeRoedeToCalculations < ActiveRecord::Migration
  def change
    add_column :calculations, :type_roede, :string
  end
end
