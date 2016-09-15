class CreateLeverancierRegels < ActiveRecord::Migration
  def change
    create_table :leverancier_regels do |t|
      t.string :input
      t.belongs_to :leverancier, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
