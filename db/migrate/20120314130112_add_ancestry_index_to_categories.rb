class AddAncestryIndexToCategories < ActiveRecord::Migration
  def change
  	add_index :categories, :ancestry
  end
end
