class ChangeCalculationTypeToRaamType < ActiveRecord::Migration
  def change
    rename_column :calculations, :type, :raam_type
  end
end
