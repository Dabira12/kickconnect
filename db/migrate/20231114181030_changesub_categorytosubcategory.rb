class ChangesubCategorytosubcategory < ActiveRecord::Migration[7.0]
  def change
    rename_column :listings, :sub_category, :subcategory
  end
end
