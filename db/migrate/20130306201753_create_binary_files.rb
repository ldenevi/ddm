class CreateBinaryFiles < ActiveRecord::Migration
  def change
    create_table :binary_files do |t|
      t.string  :filename,        :null => true
      # t.binary  :data,            :null => false
      t.text    :mime_types,      :null => true
      t.integer :attachable_id,   :null => true
      t.string  :attachable_type, :null => true
      t.string  :type
      
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
