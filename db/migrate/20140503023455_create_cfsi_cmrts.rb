class CreateCfsiCmrts < ActiveRecord::Migration
  def change
    create_table :cfsi_cmrts do |t|
      t.string :company_name
      t.references :declaration
      t.string :file_extension
      t.string :file_name
      t.boolean :is_latest
      t.string :language
      t.string :meta_data
      t.references :spreadsheet
      t.string :representative_email
      t.string :version
      t.references :minerals_vendor

      t.timestamps
    end
    add_index :cfsi_cmrts, :declaration_id
    add_index :cfsi_cmrts, :spreadsheet_id
    add_index :cfsi_cmrts, :minerals_vendor_id
  end
end
