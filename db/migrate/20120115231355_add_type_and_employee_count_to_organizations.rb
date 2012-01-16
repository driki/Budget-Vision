class AddTypeAndEmployeeCountToOrganizations < ActiveRecord::Migration
  def change
  	add_column :organizations, :employee_count, :integer
  	add_column :organizations, :type, :string
  end
end
