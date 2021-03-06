class CreateEiccStandardSmelterNames < ActiveRecord::Migration
  def change
    create_table :eicc_standard_smelter_names do |t|
      t.integer :declaration_id
      t.string :metal
      t.string :standard_smelter_name
      t.text :known_alias
      t.string :facility_location_country
      t.string :smelter_id
      t.text   :risk_level => ""

      t.timestamps
    end
  end
end
