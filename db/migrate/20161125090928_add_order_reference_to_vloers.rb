class AddOrderReferenceToVloers < ActiveRecord::Migration
  def change
    add_reference :vloers, :order, index: true, foreign_key: true
  end
end
