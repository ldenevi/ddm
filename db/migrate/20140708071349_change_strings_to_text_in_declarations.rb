class ChangeStringsToTextInDeclarations < ActiveRecord::Migration
  def up
    change_column :cfsi_declarations, :address, :text
    change_column :cfsi_declarations, :authorized_company_representative_name, :text
    change_column :cfsi_declarations, :company_name, :text
    change_column :cfsi_declarations, :company_unique_identifier, :text
    change_column :cfsi_declarations, :contact_email, :text
    change_column :cfsi_declarations, :description_of_scope, :text
  end

  def down
    change_column :cfsi_declarations, :address, :string
    change_column :cfsi_declarations, :authorized_company_representative_name, :string
    change_column :cfsi_declarations, :company_name, :string
    change_column :cfsi_declarations, :company_unique_identifier, :string
    change_column :cfsi_declarations, :contact_email, :string
    change_column :cfsi_declarations, :description_of_scope, :string
  end
end
