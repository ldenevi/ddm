class ChangeColumnTypeOfStandardSmelterNamesToTextInCfsiMineralSmelters < ActiveRecord::Migration
  def up
    change_column :cfsi_mineral_smelters, :standard_smelter_name, :text
    change_column :cfsi_mineral_smelters, :facility_contact_email, :text
    change_column :cfsi_mineral_smelters, :facility_contact_name, :text
    change_column :cfsi_mineral_smelters, :facility_location_city, :text
    change_column :cfsi_mineral_smelters, :facility_location_country, :text
    change_column :cfsi_mineral_smelters, :facility_location_province, :text
    change_column :cfsi_mineral_smelters, :facility_location_street_address, :text
    change_column :cfsi_mineral_smelters, :metal, :text
    change_column :cfsi_mineral_smelters, :mineral_source, :text
    change_column :cfsi_mineral_smelters, :mineral_source_location, :text
    change_column :cfsi_mineral_smelters, :smelter_id, :text
    change_column :cfsi_mineral_smelters, :smelter_reference_list, :text
    change_column :cfsi_mineral_smelters, :standard_smelter_name, :text
  end

  def down
    change_column :cfsi_mineral_smelters, :standard_smelter_name, :string
    change_column :cfsi_mineral_smelters, :facility_contact_email, :string
    change_column :cfsi_mineral_smelters, :facility_contact_name, :string
    change_column :cfsi_mineral_smelters, :facility_location_city, :string
    change_column :cfsi_mineral_smelters, :facility_location_country, :string
    change_column :cfsi_mineral_smelters, :facility_location_province, :string
    change_column :cfsi_mineral_smelters, :facility_location_street_address, :string
    change_column :cfsi_mineral_smelters, :metal, :string
    change_column :cfsi_mineral_smelters, :mineral_source, :string
    change_column :cfsi_mineral_smelters, :mineral_source_location, :string
    change_column :cfsi_mineral_smelters, :smelter_id, :string
    change_column :cfsi_mineral_smelters, :smelter_reference_list, :string
    change_column :cfsi_mineral_smelters, :standard_smelter_name, :string
  end
end
