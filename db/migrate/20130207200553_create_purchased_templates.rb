class CreatePurchasedTemplates < ActiveRecord::Migration
  def change
    create_table :purchased_templates do |t|
      t.integer :agency_id
      t.string  :agency_display_name
      t.integer :approved_by_id
      t.timestamp :approved_at
      t.string  :full_name
      t.string  :display_name
      t.string  :frequency
      t.text    :description
      t.text    :objectives
      t.text    :tasks
      t.string  :regulatory_review_name
      t.integer :organization_id
      t.integer :revision
      t.boolean :is_latest_revision
      t.integer :purchased_by_id

      t.timestamps
    end
    add_index :purchased_templates, :approved_by_id
    add_index :purchased_templates, :full_name
    add_index :purchased_templates, :display_name
    add_index :purchased_templates, :organization_id
    add_index :purchased_templates, :purchased_by_id
  end
end
