class AddIsExpenseIndexToCategories < ActiveRecord::Migration
  def change
  	add_index :categories, :is_expense
  end
end
