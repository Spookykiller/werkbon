class CreateLeveranciers < ActiveRecord::Migration
  def change
    create_table :leveranciers do |t|
      t.string :leverancier_werkbon
      t.string :leverancier_label

      t.timestamps null: false
    end
  end
end
