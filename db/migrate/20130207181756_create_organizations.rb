class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      # Display information
      t.string     :name
      t.string     :display_name
      t.references :governing_law
      t.references :owner
      
      # ECOTree Hierarchy
      t.references :parent
      t.references :root_parent
      t.boolean    :is_branch, :default => false
      t.boolean    :is_leaf,   :default => false

      t.timestamps
    end
    add_index :organizations, :name
    add_index :organizations, :display_name
    add_index :organizations, :governing_law_id
    
    #eco_tree indeces
    add_index :organizations, :root_parent_id
    add_index :organizations, :parent_id
    add_index :organizations, :is_leaf
    add_index :organizations, :is_branch
  end
end
