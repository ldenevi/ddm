class CreateCfsiMineralSmelters < ActiveRecord::Migration
  def change
    create_table :cfsi_mineral_smelters do |t|
      t.text :comment
      t.references :declaration
      t.string :facility_contact_email
      t.string :facility_contact_name
      t.string :facility_location_city
      t.string :facility_location_country
      t.string :facility_location_province
      t.string :facility_location_street_address
      t.integer :line_number
      t.string :metal
      t.string :mineral_source
      t.string :mineral_source_location
      t.text :proposed_next_steps
      t.string :smelter_id
      t.string :smelter_reference_list
      t.string :standard_smelter_name

      t.timestamps
    end
    add_index :cfsi_mineral_smelters, :declaration_id
  end
end
