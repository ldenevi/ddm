class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      # Display information
      t.references :responsible_party
      t.string     :frequency
      t.string     :name
      t.references :owner
      t.references :organization
      t.references :organization_template
      t.string     :status
      
      # Tracking
      t.timestamp :actual_completion_at
      t.timestamp :actual_start_at
      t.timestamp :targeted_completion_at
      t.timestamp :targeted_start_at
      t.timestamp :assigned_at
      t.timestamp :deployed_at
      
      t.timestamps
    end
    
    add_index :reviews, :name
    add_index :reviews, :assigned_at
    add_index :reviews, :responsible_party_id
    add_index :reviews, :organization_template_id
  end
end
