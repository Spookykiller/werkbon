class AddArticleTypeToSecondDropdowns < ActiveRecord::Migration
  def change
    add_column :second_dropdowns, :article_type, :string
  end
end
