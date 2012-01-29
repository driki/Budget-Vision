class AddDefaultValueToProjectExpenseRevenueBudgets < ActiveRecord::Migration
  def change
  	change_column(:projects, :expense_budget, :float, :default => 0)
  	change_column(:projects, :revenue_budget, :float, :default => 0)
  	change_column(:projects, :average_tax_bill, :float, :default => 0)
  end
end
