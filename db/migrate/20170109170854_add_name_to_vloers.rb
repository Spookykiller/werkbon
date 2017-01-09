class AddNameToVloers < ActiveRecord::Migration
  def change
    add_column :vloers, :name, :string
  end
end
