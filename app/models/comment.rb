class Comment < ActiveRecord::Base
  attr_accessible :attachments_count, :author, :body, :title
  
  belongs_to :author, :class_name => 'User'
end
