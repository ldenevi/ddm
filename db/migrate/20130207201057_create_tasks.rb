class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :instructions
      t.integer :review_id
      t.integer :sequence
      t.string :status
      t.timestamp :assigned_at
      t.timestamp :expected_completion_at
      t.timestamp :actual_completion_at
      t.float :completion_percentage

      t.timestamps
    end
    add_index :tasks, :review_id
    add_index :tasks, :status
  end
end
