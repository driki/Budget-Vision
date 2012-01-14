class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string    :name
      t.text      :goal
      t.text      :challenge
      t.text      :description
      t.float     :expense_budget
      t.float     :revenue_budget
      t.string    :tags

      t.references :project

      t.timestamps
    end
  end
end
