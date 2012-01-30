class AddIsExpenseToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :is_expense, :boolean, :default => true
    remove_column :categories, :type

    Category.tagged_with("revenue").each do |category|
      category.update_attributes!(:is_expense => false)
    end
  end

  def self.down
    remove_column :categories, :is_expense
    add_column :categories, :type, :string
  end
end
