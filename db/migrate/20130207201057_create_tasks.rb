class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      # Display information
      t.references :reviewer, :null => false
      t.float      :completion_percentage
      t.text       :instructions, :null => false
      t.string     :name
      t.references :review, :null => false
      t.integer    :sequence, :null => false, :default => 1
      t.string     :status, :null => false, :default => GSP::STATUS::TASK::INACTIVE
      
      # Tracking
      t.timestamp :actual_completion_at
      t.timestamp :assigned_at
      t.timestamp :expected_completion_at, :null => false, :default => (Time.now + 14.days)
      t.timestamp :start_at

      t.timestamps
    end
    add_index :tasks, :reviewer_id
    add_index :tasks, :review_id
    add_index :tasks, :status
  end
end
