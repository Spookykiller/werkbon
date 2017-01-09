class AddRoleToUsers < ActiveRecord::Migration
  def change
    # te beheren: alles (0), shop (1), meting (2), administratie (3), bestelafdeling (4), planning (5)
    add_column :users, :role, :integer
  end
end
