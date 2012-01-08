class CreateOrganizationUsers < ActiveRecord::Migration
  def change
    create_table :organization_users do |t|
      t.integer :user_id
      t.integer :organization_id
      
      t.timestamps
    end
  end
end
