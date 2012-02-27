class AddWebsiteVendorToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :website_vendor, :string
  end
end
