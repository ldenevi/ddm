class AddTemplateVersionToEiccDeclarationAndValidationStatus < ActiveRecord::Migration
  def change
    add_column :eicc_declarations, :template_version, :string
    add_column :eicc_validation_statuses, :template_version, :string
  end
end
