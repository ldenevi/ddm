class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      # Display information
      t.references :owner
      t.string     :frequency
      t.string     :name
      t.references :organization
      t.references :purchased_template
      t.string     :status
      
      # Tracking
      t.timestamp :actual_completion_at
      t.timestamp :assigned_at
      t.timestamp :deployed_at
      t.timestamp :due_at
      t.timestamp :start_at
      
      t.timestamps
    end
    
    add_index :reviews, :name
    add_index :reviews, :assigned_at
    add_index :reviews, :owner_id
    add_index :reviews, :purchased_template_id
  end
end
