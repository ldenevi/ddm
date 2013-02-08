class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :display_name
      t.integer :region_id
      t.integer :parent_id
      t.integer :root_parent_id
      t.boolean :is_leaf, :default => false
      t.boolean :is_branch, :default => false
      t.integer :owner_id

      t.timestamps
    end
    add_index :organizations, :name
    add_index :organizations, :display_name
    add_index :organizations, :region_id
    add_index :organizations, :root_parent_id
    add_index :organizations, :parent_id
    add_index :organizations, :is_leaf
    add_index :organizations, :is_branch
  end
end
