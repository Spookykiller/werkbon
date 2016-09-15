class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :werkbon
      t.decimal :ruimte
      t.decimal :breedte
      t.decimal :hoogte
      t.boolean :stuks
      t.boolean :bed
      t.boolean :voeren
      t.decimal :hoofdje
      t.boolean :bediening
      t.string :type
      t.boolean :uitlijnen
      t.boolean :bmdm
      t.belongs_to :vloer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
