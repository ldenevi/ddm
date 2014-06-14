class AddVersion3ColumnsToCfsiDeclarations < ActiveRecord::Migration
  def change
    add_column :cfsi_declarations, :company_unique_id_authority, :string
    add_column :cfsi_declarations, :contact_name, :string
    add_column :cfsi_declarations, :authorizer, :string
    add_column :cfsi_declarations, :authorizer_title, :string
    add_column :cfsi_declarations, :authorizer_email, :string
    add_column :cfsi_declarations, :authorizer_phone, :string
    add_column :cfsi_declarations, :effective_date, :datetime
  end
end
