class AddDefaultValueToCategoryForExpenseRevenue < ActiveRecord::Migration
  def change
  	change_column(:categories, :expense_budget, :float, :default => 0)
  	change_column(:categories, :revenue_budget, :float, :default => 0)
  end
end
