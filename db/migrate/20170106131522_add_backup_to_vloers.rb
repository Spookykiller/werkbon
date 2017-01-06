class AddBackupToVloers < ActiveRecord::Migration
  def change
    add_column :vloers, :backup, :boolean
  end
end
