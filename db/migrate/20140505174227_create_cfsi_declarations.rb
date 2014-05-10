class CreateCfsiDeclarations < ActiveRecord::Migration
  def change
    create_table :cfsi_declarations do |t|
      t.string :address
      t.string :authorized_company_representative_name
      t.string :company_name
      t.string :company_unique_identifier
      t.datetime :completion_at
      t.string :contact_email
      t.string :contact_phone
      t.string :contact_title
      t.text   :csv_worksheets
      t.string :declaration_scope
      t.string :description_of_scope
      t.string :language
      t.string :version

      t.timestamps
    end
  end
end
