class Comment < ActiveRecord::Base
  # Display information
  attr_accessible :attachments_count, :body, :title
  belongs_to :commentable, :polymorphic => true
  
  # Tracking
  attr_accessible :author, :author_id
  belongs_to      :author, :class_name => 'User'
  
  # Relationships
  has_many :attachments, :as => :attachable, :class_name => 'BinaryFile'
end
