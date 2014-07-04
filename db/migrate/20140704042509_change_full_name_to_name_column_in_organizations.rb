class ChangeFullNameToNameColumnInOrganizations < ActiveRecord::Migration
  def up
    add_column :organizations, :logo, :binary, :limit => 2.megabytes
    add_column :organizations, :name, :string
    Organization.all.each do |org|
      org.update_attribute(:name, org.full_name)
    end
    remove_column :organizations, :full_name
  end

  def down
    add_column :organizations, :full_name, :string
    Organization.all.each do |org|
      org.update_attribute(:full_name, org.name)
    end
    remove_column :organizations, :name
  end
end
