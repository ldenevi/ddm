class CreateEiccConfirmedSmelters < ActiveRecord::Migration
  def change
    create_table :eicc_confirmed_smelters do |t|
      t.string :type
      t.string :metal
      t.string :standard_smelter_id
      t.string :smelter_name
      t.string :locations
      t.datetime :invalid_at
      t.string :conflict_mineral_policy_url
      t.references :user

      t.timestamps
    end
    add_index :eicc_confirmed_smelters, :user_id
  end
end
