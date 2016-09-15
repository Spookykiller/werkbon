class AddBijzonderhedenToVloers < ActiveRecord::Migration
  def change
    add_column :vloers, :bijzonderheden, :text
  end
end
