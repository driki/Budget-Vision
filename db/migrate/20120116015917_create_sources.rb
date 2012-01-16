class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
    	t.string			:title
    	t.string			:url
    	t.text				:description
			t.references  :project

      t.timestamps
    end
  end
end