class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :omschrijving
      t.decimal :prijs
      t.string :eenheid

      t.timestamps null: false
    end
  end
end
