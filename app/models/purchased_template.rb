class PurchasedTemplate < ActiveRecord::Base
  attr_accessible :agency, :description, :display_name, :frequency,
                  :full_name, :is_latest_revision, :objectives,
                  :organization, :regulatory_review_name, :revision,
                  :approved_by, :arroved_at, :purchased_by, :tasks
  
  belongs_to :agency
  belongs_to :approved_by, :class_name => 'User'
  belongs_to :organization
  belongs_to :purchased_by, :class_name => 'User'
  
  def deploy_reviews
    
  end
end
