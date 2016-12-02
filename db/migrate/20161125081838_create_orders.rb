class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :naam
      t.string :project_nummer
      t.string :project_naam
      t.string :AdressLine1
      t.string :AdressLine3
      t.string :AdressLine4
      t.string :telefoon
      t.string :email
      t.string :contactpersoon
      t.string :oplevering
      t.string :ordernummer
      t.decimal :totale_prijs, :default => 0
      t.decimal :totale_arbeid, :default => 0
      
      t.timestamps null: false
    end
  end
end
