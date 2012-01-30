class RemoveAwesomeNestedSetFromCategory < ActiveRecord::Migration
  def up
  	remove_column :categories, :parent_id
  	remove_column :categories, :lft
  	remove_column :categories, :rgt
  	remove_column :categories, :depth
  end

  def down
    add_column :categories, :parent_id, :integer
  	add_column :categories, :lft, :integer
  	add_column :categories, :rgt, :integer
  	add_column :categories, :depth, :integer
  end
end
