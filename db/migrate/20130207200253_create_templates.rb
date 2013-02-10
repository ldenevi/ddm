class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      # Display information
      t.float      :price
      t.references :agency
      t.string     :agency_display_name
      t.text       :description
      t.string     :display_name
      t.string     :frequency
      t.string     :full_name
      t.text       :objectives
      t.string     :regulatory_review_name
      t.text       :tasks
      
      # Tracking
      t.references :author
      t.text       :reasons_for_update
      
      # Rails
      t.references :parent
      t.timestamps
    end
    add_index :templates, :agency_id
    add_index :templates, :agency_display_name
    add_index :templates, :author_id
    add_index :templates, :display_name
    add_index :templates, :full_name
  end
end
