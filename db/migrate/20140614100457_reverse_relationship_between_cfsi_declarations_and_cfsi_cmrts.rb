class ReverseRelationshipBetweenCfsiDeclarationsAndCfsiCmrts < ActiveRecord::Migration
  def up
    remove_column :cfsi_cmrts, :declaration_id
    add_column :cfsi_declarations, :cmrt_id, :integer
    add_index :cfsi_declarations, :cmrt_id
  end

  def down
    add_column :cfsi_cmrts, :declaration_id, :integer
    remove_column :cfsi_declarations, :cmrt_id
  end
end
