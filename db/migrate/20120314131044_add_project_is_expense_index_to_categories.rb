class AddProjectIsExpenseIndexToCategories < ActiveRecord::Migration
  def change
  	add_index :categories, [:project_id, :is_expense]
  end
end
