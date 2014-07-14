class CreateCfsiReportsSmelterReferences < ActiveRecord::Migration
  def change
    create_table :cfsi_reports_smelter_references do |t|
      t.string :metal
      t.string :country
      t.string :standard_name
      t.text :key_terms
      t.string :v2_smelter_id
      t.string :v3_smelter_id

      t.timestamps
    end
  end
end
