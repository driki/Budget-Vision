class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string      :number
      t.string      :name
      t.text        :description
      t.float       :total
      t.string      :tags
      t.references  :category

      t.timestamps
    end
    add_index(:items, :category_id)
  end
end
