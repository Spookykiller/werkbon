class ChangeOrganisatieTypeInVloers < ActiveRecord::Migration
  def change
    change_column :vloers, :organisatie, :integer
  end
end
