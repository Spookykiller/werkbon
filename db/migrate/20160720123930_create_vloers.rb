class CreateVloers < ActiveRecord::Migration
  def change
    create_table :vloers do |t|
      t.string :naam
      t.string :project_nummer
      t.string :project_naam
      t.string :AdressLine1
      t.string :AdressLine3
      t.string :AdressLine4
      t.string :telefoon
      t.string :email
      t.boolean :organisatie
      t.string :contactpersoon
      t.string :datum
      t.string :werkvoorbereider
      t.string :oplevering
      t.string :ordernummer
      t.string :werkbon_type
      t.decimal :totale_prijs
      t.decimal :totale_arbeid

      t.timestamps null: false
    end
  end
end
