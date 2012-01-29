class AddIsExpenseToLineItem < ActiveRecord::Migration
  def change
  	add_column :items, :is_expense, :boolean, :default => true
  end
end
