class AddSecurityColumnsToCfsiTables < ActiveRecord::Migration
  def up
    add_column :cfsi_declarations, :organization_id, :integer
    add_column :cfsi_minerals_questions, :organization_id, :integer
    add_column :cfsi_company_level_questions, :organization_id, :integer
    add_column :cfsi_mineral_smelters, :organization_id, :integer
    add_column :cfsi_standard_smelter_names, :organization_id, :integer
    add_column :cfsi_products, :organization_id, :integer
    add_column :cfsi_cmrts, :organization_id, :integer
    add_column :cfsi_cmrt_validations, :organization_id, :integer
    add_column :cfsi_cmrt_validations, :user_id, :integer
  end

  def down
    remove_column :cfsi_declarations, :organization_id
    remove_column :cfsi_minerals_questions, :organization_id
    remove_column :cfsi_company_level_questions, :organization_id
    remove_column :cfsi_mineral_smelters, :organization_id
    remove_column :cfsi_standard_smelter_names, :organization_id
    remove_column :cfsi_products, :organization_id
    remove_column :cfsi_cmrts, :organization_id
    remove_column :cfsi_cmrt_validations, :organization_id
    remove_column :cfsi_cmrt_validations, :user_id
  end
end
