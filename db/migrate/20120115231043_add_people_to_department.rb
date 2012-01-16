class AddPeopleToDepartment < ActiveRecord::Migration
  def change
  	add_column :categories, :people, :integer
  end
end
