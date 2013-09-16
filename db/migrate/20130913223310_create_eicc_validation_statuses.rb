class CreateEiccValidationStatuses < ActiveRecord::Migration
  def change
    create_table :eicc_validation_statuses do |t|
      t.string  :type
      t.integer :parent_id
      t.integer :user_id, :null => true
      t.string  :uploaded_file_path, :null => true
      t.string  :filename, :null => true
      t.string  :status, :null => false
      t.string  :representative_email
      t.text    :message
      t.boolean :is_spreadsheet_return_email_sent, :default => "false"

      t.timestamps
    end
  end
end
