class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      # Display information
      t.string :name
      t.string :acronym
      t.string :website

      t.timestamps
    end
    add_index :agencies, :name
    add_index :agencies, :acronym
  end
end
