class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :number
      t.string :name
      t.text :description
      t.float :total
      t.boolean :is_expense
      t.string :type
      t.references :category

      t.timestamps
    end
  end
end
