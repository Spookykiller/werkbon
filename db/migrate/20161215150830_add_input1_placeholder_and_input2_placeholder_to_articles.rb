class AddInput1PlaceholderAndInput2PlaceholderToArticles < ActiveRecord::Migration
  def change
      add_column :articles, :input1_placeholder, :string
      add_column :articles, :input2_placeholder, :string
  end
end
