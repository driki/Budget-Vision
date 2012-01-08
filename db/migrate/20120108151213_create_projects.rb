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
      t.boolean :enable_comments
      t.boolean :enable_tips
      t.boolean :is_demo
      
      t.references :organization

      t.timestamps
    end
  end
end
