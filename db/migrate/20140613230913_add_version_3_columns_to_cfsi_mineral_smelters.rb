class AddVersion3ColumnsToCfsiMineralSmelters < ActiveRecord::Migration
  def change
    add_column :cfsi_mineral_smelters, :source_of_smelter_id, :string
    add_column :cfsi_mineral_smelters, :is_all_smelter_feedstock_from_recycled_sources, :string
  end
end
