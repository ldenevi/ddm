class CreateEiccSmelterLists < ActiveRecord::Migration
  def change
    create_table :eicc_smelter_lists do |t|
      t.integer :declaration_id
      t.integer :line_number
      t.string :metal, :default => ""
      t.string :smelter_reference_list, :default => ""
      t.string :standard_smelter_name, :default => ""
      t.string :facility_location_country, :default => ""
      t.string :smelter_id
      t.string :facility_location_street_address
      t.string :facility_location_city
      t.string :facility_location_province
      t.string :facility_contact_name
      t.string :facility_contact_email
      t.string :proposed_next_steps
      t.string :mineral_source
      t.string :mineral_source_location
      t.text :comment

      t.timestamps
    end
  end
end
