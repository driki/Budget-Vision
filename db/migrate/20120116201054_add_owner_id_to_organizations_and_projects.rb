class AddOwnerIdToOrganizationsAndProjects < ActiveRecord::Migration
  def self.up
    rename_column :organizations, :opener_id, :owner_id
    add_column :projects, :owner_id, :integer
  end

  def self.down
    rename_column :organizations, :owner_id, :opener_id
    remove_column :projects, :owner_id
  end
end
