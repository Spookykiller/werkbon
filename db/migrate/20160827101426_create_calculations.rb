class CreateCalculations < ActiveRecord::Migration
  def change
    create_table :calculations do |t|
      t.string :werkbon
      t.string :ruimte
      t.decimal :aantal
      t.decimal :breedte
      t.decimal :hoogte
      t.string :strakke_hoogte_maat
      t.boolean :bmdm
      t.string :stuks
      t.decimal :hoofdje
      t.decimal :rail_lengte
      t.string :bocht
      t.string :montage
      t.boolean :bediening
      t.decimal :montage_hoogte
      t.string :plaatsing
      
      t.boolean :bed
      t.string :type
      t.boolean :uitlijnen
      
      t.belongs_to :vloer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
