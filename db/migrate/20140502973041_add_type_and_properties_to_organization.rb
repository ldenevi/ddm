class AddTypeAndPropertiesToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :type, :string
    add_column :organizations, :properties, :string
  end
end
