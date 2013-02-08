class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.integer :agency_id
      t.string :agency_display_name
      t.string :display_name
      t.string :full_name
      t.string :frequency
      t.text :description
      t.text :objectives
      t.string :regulatory_review_name
      t.integer :author_id
      t.text :tasks

      t.timestamps
    end
    add_index :templates, :agency_id
    add_index :templates, :agency_display_name
    add_index :templates, :display_name
    add_index :templates, :full_name
    add_index :templates, :author_id
  end
end
