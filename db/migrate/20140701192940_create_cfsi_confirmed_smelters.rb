class CreateCfsiConfirmedSmelters < ActiveRecord::Migration
  def change
    create_table :cfsi_confirmed_smelters do |t|
      t.datetime :invalid_at
      t.text :locations
      t.string :mineral
      t.string :name
      t.string :source
      t.string :status
      t.string :v3_smelter_id

      t.timestamps
    end
  end
end
