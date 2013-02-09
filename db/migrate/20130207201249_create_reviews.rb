class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :owner_id
      t.string :frequency
      t.string :status
      t.timestamp :assigned_at
      t.timestamp :deployed_at
      t.timestamp :start_at
      t.timestamp :due_at
      t.timestamp :actual_completion_at

      t.timestamps
    end
    
    add_index :reviews, :name
    add_index :reviews, :assigned_at
    add_index :reviews, :owner_id
  end
end
