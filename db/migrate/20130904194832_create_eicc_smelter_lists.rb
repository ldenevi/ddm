class CreateEiccSmelterLists < ActiveRecord::Migration
  def change
    create_table :eicc_smelter_lists do |t|
      t.integer :declaration_id
      t.integer :line_number
      t.text :metal, :default => ""
      t.text :smelter_reference_list, :default => ""
      t.text :standard_smelter_name, :default => ""
      t.text :facility_location_country, :default => ""
      t.text :smelter_id
      t.text :facility_location_street_address
      t.text :facility_location_city
      t.text :facility_location_province
      t.text :facility_contact_name
      t.text :facility_contact_email
      t.text :proposed_next_steps
      t.text :mineral_source
      t.text :mineral_source_location
      t.text :comment
      t.text :risk_level => ""

      t.timestamps
    end
  end
end
