class RemoveCsvWorksheetsColumnFromCfsiDeclarations < ActiveRecord::Migration
  def up
    remove_column :cfsi_declarations, :csv_worksheets
  end

  def down
    add_column :cfsi_declarations, :csv_worksheets, :text
  end
end
