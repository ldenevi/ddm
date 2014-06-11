class CreateCfsiCompanyLevelQuestions < ActiveRecord::Migration
  def change
    create_table :cfsi_company_level_questions do |t|
      t.integer :sequence
      t.string :question
      t.text :answer
      t.text :comment
      t.references :declaration

      t.timestamps
    end
    add_index :cfsi_company_level_questions, :declaration_id
  end
end
