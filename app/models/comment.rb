class Comment < ActiveRecord::Base
  # Display information
  attr_accessible :attachments_count, :body, :title
  belongs_to :commentable, :polymorphic => true
  
  # Tracking
  attr_accessible :author
  belongs_to      :author, :class_name => 'User'
end
