class AddSequenceIdToLeveranciers < ActiveRecord::Migration
  def change
    add_column :leveranciers, :sequence_id, :integer
  end
end
