class ChangeCommentColumnTypeToTextInMineralsQuestions < ActiveRecord::Migration
  def up
    change_column :cfsi_minerals_questions, :gold_comment, :text
    change_column :cfsi_minerals_questions, :tantalum_comment, :text
    change_column :cfsi_minerals_questions, :tin_comment, :text
    change_column :cfsi_minerals_questions, :tungsten_comment, :text
  end

  def down
    change_column :cfsi_minerals_questions, :gold_comment, :string
    change_column :cfsi_minerals_questions, :tantalum_comment, :string
    change_column :cfsi_minerals_questions, :tin_comment, :string
    change_column :cfsi_minerals_questions, :tungsten_comment, :string
  end
end
