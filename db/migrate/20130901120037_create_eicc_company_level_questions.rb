class CreateEiccCompanyLevelQuestions < ActiveRecord::Migration
  def change
    create_table :eicc_company_level_questions do |t|
      t.integer :declaration_id
      t.integer :sequence
      t.text :question
      t.text :answer, :default => ''
      t.text :comment

      t.timestamps
    end
  end
end
