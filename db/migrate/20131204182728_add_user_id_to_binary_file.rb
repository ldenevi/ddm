class AddUserIdToBinaryFile < ActiveRecord::Migration
  def change
    add_column :binary_files, :user_id, :integer
  end
end
