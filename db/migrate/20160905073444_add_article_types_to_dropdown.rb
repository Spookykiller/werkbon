class AddArticleTypesToDropdown < ActiveRecord::Migration
  def change
    add_column :dropdowns, :article_type, :string
  end
end
