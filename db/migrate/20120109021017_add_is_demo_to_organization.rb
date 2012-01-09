class AddIsDemoToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :is_demo, :boolean
  end

  def up 
    add_index organizations, :is_demo
  end

  def down
    remove_index organizations, :is_demo
  end
end
