class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      # Display information
      t.references :executor
      t.float      :completion_percentage
      t.string     :instructions
      t.string     :name
      t.references :review
      t.integer    :sequence
      t.string     :status
      
      # Tracking
      t.timestamp :actual_completion_at
      t.timestamp :assigned_at
      t.timestamp :expected_completion_at
      t.timestamp :start_at

      t.timestamps
    end
    add_index :tasks, :executor_id
    add_index :tasks, :review_id
    add_index :tasks, :status
  end
end
