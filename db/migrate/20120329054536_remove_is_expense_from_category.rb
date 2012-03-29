class RemoveIsExpenseFromCategory < ActiveRecord::Migration
  def up
  	remove_column :categories, :expense_budget
  	remove_column :categories, :revenue_budget
  	remove_column :categories, :is_expense
  end

  def down
  end
end
