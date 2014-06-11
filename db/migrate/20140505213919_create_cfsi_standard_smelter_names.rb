class CreateCfsiStandardSmelterNames < ActiveRecord::Migration
  def change
    create_table :cfsi_standard_smelter_names do |t|
      t.references :declaration
      t.string :facility_location_country
      t.string :known_alias
      t.string :metal
      t.string :smelter_id
      t.string :standard_smelter_name

      t.timestamps
    end
    add_index :cfsi_standard_smelter_names, :declaration_id
  end
end
