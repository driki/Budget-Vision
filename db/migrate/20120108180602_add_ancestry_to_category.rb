class AddAncestryToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry, :string
  end

  def up 
    add_index categories, :ancestry
  end

  def down
    remove_index categories, :ancestry
  end
end
