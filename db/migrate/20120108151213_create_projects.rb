class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.string :title
      t.text :description
      t.text :summary
      t.float :expense_budget
      t.float :revenue_budget
      t.string :type
      t.integer :year
      t.float :average_tax_bill
      t.boolean :enable_comments, :default => true
      t.boolean :enable_tips, :default => false
      t.boolean :is_demo, :default => false
      
      t.references :organization

      t.timestamps
    end
  end
end
