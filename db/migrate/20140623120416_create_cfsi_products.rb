class CreateCfsiProducts < ActiveRecord::Migration
  def change
    create_table :cfsi_products do |t|
      t.string :item_number
      t.string :item_name
      t.text :comment
      t.references :declaration

      t.timestamps
    end
    add_index :cfsi_products, :declaration_id
  end
end
