class AddCsvToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :csv, :string
  end
end
