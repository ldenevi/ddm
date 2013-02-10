class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      # Display information
      t.string     :title
      t.text       :body
      t.integer    :attachments_count
      
      # Rails
      t.references :commentable, :polymorphic => true
      t.timestamps

      # Tracking
      t.integer :author_id
    end
    add_index :comments, :title
    add_index :comments, :body
    add_index :comments, :author_id
  end
end
