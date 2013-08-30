class CreateEiccDeclarationQuestions < ActiveRecord::Migration
  def change
    create_table :eicc_declaration_questions do |t|
      t.integer :declaration_id
      t.integer :sequence
      t.text :question
      t.string :tantalum
      t.text :tantalum_comment
      t.string :tungsten
      t.text :tungsten_comment
      t.string :tin
      t.text :tin_comment
      t.string :gold
      t.text :gold_comment

      t.timestamps
    end
  end
end
