class AddColumnsToEiccSmelterLists < ActiveRecord::Migration
  def change
    add_column :eicc_smelter_lists, :source_of_smelter_id, :string
    add_column :eicc_smelter_lists, :is_all_smelter_feedstock_from_recycled_sources, :string
  end
end
