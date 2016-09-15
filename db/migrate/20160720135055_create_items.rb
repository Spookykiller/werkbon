class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :hoeveelheid
      t.string :omschrijving
      t.string :var1
      t.string :var1_name
      t.string :var2
      t.string :var2_name
      t.string :var3
      t.string :var3_name
      t.string :var4
      t.string :var4_name
      t.decimal :article_prijs
      t.decimal :prijs
      t.decimal :totale_prijs
      t.decimal :totale_arbeid
      t.string :werkbon_type
      t.belongs_to :vloer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
