class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.string :name
      t.text :description
      t.references :project

      t.timestamps
    end
  end
end
