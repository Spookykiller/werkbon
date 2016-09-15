class CreateRegels < ActiveRecord::Migration
  def change
    create_table :regels do |t|
      t.string :werkbon
      t.string :article_type
      t.string :leverancier_name
      t.string :label
      t.string :var_1_eenheid
      t.string :var_2_eenheid

      t.timestamps null: false
    end
  end
end
