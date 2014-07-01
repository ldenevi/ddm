class AddOrganizationIdColumnToOrganizations < ActiveRecord::Migration
  def up
    add_column :organizations, :organization_id, :integer
  end

  def down
    remove_column :organizations, :organization_id
  end
end
