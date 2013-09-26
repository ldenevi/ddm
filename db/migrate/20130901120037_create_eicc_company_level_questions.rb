class CreateEiccCompanyLevelQuestions < ActiveRecord::Migration
  def change
    create_table :eicc_company_level_questions do |t|
      t.integer :declaration_id
      t.integer :sequence, :default => 0
      t.text    :question, :default => ""
      t.text    :answer, :default => ""
      t.text    :comment
      t.text    :risk_level => ""

      t.timestamps
    end
  end
end
