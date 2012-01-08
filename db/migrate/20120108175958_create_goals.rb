class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :name
      t.text :description
      t.text :summary
      t.references :project

      t.timestamps
    end
  end
end
