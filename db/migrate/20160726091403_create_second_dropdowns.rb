class CreateSecondDropdowns < ActiveRecord::Migration
  def change
    create_table :second_dropdowns do |t|
      t.string :input
      t.belongs_to :regel, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
