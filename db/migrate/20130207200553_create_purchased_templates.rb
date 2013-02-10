class CreatePurchasedTemplates < ActiveRecord::Migration
  def change
    create_table :purchased_templates do |t|
      # Display information
      t.integer    :agency_id
      t.string     :agency_display_name
      t.text       :description
      t.string     :display_name
      t.string     :frequency
      t.string     :full_name
      t.text       :objectives
      t.references :organization
      t.string     :regulatory_review_name
      t.references :template
      
      # Revisions
      t.integer    :revision
      t.boolean    :is_latest_revision
    
      t.text    :tasks
      
      # Search filters
      t.boolean    :is_archived
      
      # Tracking
      t.references :approved_by
      t.timestamp  :approved_at
      t.references :modified_by
      t.references :purchased_by
      t.references :shared_by
      t.timestamp  :shared_at
      
      # ECOTree Hierarchy
      t.references :parent
      t.references :root_parent
      t.boolean    :is_branch, :default => false
      t.boolean    :is_leaf,   :default => false

      t.timestamps
    end
    
    add_index :purchased_templates, :approved_by_id
    add_index :purchased_templates, :full_name
    add_index :purchased_templates, :display_name
    add_index :purchased_templates, :organization_id
    add_index :purchased_templates, :purchased_by_id
  end
end
