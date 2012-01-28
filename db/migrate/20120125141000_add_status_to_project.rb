class AddStatusToProject < ActiveRecord::Migration
  def change
  	#values for status should be in-progress --> draft --> approved --> revised
  	add_column :projects, :status, :string
  end
end
