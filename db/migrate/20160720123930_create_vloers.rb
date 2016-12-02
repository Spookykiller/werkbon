class CreateVloers < ActiveRecord::Migration
  def change
    create_table :vloers do |t|
      t.integer :organisatie
      t.string :datum
      t.string :werkvoorbereider
      t.string :werkbon_type
      t.decimal :totale_prijs, :default => 0
      t.decimal :totale_arbeid, :default => 0
      t.text :bijzonderheden
      t.integer :status, :default => 0

      t.timestamps null: false
    end
  end
end
