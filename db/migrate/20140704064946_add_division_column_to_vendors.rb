class AddDivisionColumnToVendors < ActiveRecord::Migration
  def up
    add_column :organizations, :division_id, :integer
  end

  def down
    remove_column :organizations, :division_id
  end
end
