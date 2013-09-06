class CreateEiccMineralsQuestions < ActiveRecord::Migration
  def change
    create_table :eicc_minerals_questions do |t|
      t.integer :declaration_id
      t.integer :sequence
      t.text :question
      t.string :tantalum, :default => ""
      t.text :tantalum_comment
      t.string :tungsten, :default => ""
      t.text :tungsten_comment
      t.string :tin, :default => ""
      t.text :tin_comment
      t.string :gold, :default => ""
      t.text :gold_comment

      t.timestamps
    end
  end
end
