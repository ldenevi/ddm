class CreateCfsiMineralsQuestions < ActiveRecord::Migration
  def change
    create_table :cfsi_minerals_questions do |t|
      t.integer :sequence
      t.string :question
      t.references :declaration
      t.string :gold
      t.string :gold_comment
      t.string :tantalum
      t.string :tantalum_comment
      t.string :tin
      t.string :tin_comment
      t.string :tungsten
      t.string :tungsten_comment

      t.timestamps
    end
    add_index :cfsi_minerals_questions, :declaration_id
  end
end
