class AddIsExpenseToLineItem < ActiveRecord::Migration
  def change
  	add_column :items, :is_expense, :boolean, :default => 1
  end
end
