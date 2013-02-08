class PurchasedTemplate < ActiveRecord::Base
  attr_accessible :agency, :description, :display_name, :frequency, :full_name, :is_latest_revision, :objectives, :organization, :regulatory_review_name, :revision
  
  belongs_to :agency
  belongs_to :organization
  belongs_to :purchased_by, :class_name => 'User'
end
