class AddColumnsToCfsiMineralSmelters < ActiveRecord::Migration
  def change
    add_column :cfsi_mineral_smelters, :v2_smelter_id, :string
    add_column :cfsi_mineral_smelters, :v3_smelter_id, :string
    remove_column :cfsi_mineral_smelters, :smelter_id
  end
end
