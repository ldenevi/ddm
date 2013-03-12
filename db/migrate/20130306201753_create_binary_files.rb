class CreateBinaryFiles < ActiveRecord::Migration
  def change
    create_table :binary_files do |t|
      t.string  :filename,        :null => false
      # t.binary  :data,            :null => false
      t.text    :mime_types,      :null => false
      t.integer :attachable_id,   :null => false
      t.string  :attachable_type, :null => false
      t.string  :type,            :null => false
      
      # GSP::FileManager::Storage
      t.string :storage_path,     :null => false

      t.timestamps
    end
    add_index :binary_files, :filename
    add_index :binary_files, :mime_types
    add_index :binary_files, :attachable_id
    add_index :binary_files, :attachable_type
    add_index :binary_files, :type
  end
end
