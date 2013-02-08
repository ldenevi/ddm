class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string  :title
      t.text    :body
      t.integer :author_id
      t.integer :attachments_count
      t.references :attachable, :polymorphic => true

      t.timestamps
    end
    add_index :comments, :body
    add_index :comments, :author_id
  end
end
