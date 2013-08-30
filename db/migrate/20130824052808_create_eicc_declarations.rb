class CreateEiccDeclarations < ActiveRecord::Migration
  def change
    create_table :eicc_declarations do |t|
      t.integer :client_id
      t.integer :task_id
      t.datetime :gsp_template_input_at
      t.string :validation_status
      t.string :language
      t.datetime :completion_at
      t.text :invalid_reasons
      t.string :company_name
      t.text :declaration_scope
      t.text :description_of_scope
      t.string :company_unique_identifier
      t.string :address
      t.string :authorized_company_representative_name
      t.string :representative_title
      t.string :representative_email
      t.string :representative_phone

      t.timestamps
    end
  end
end
