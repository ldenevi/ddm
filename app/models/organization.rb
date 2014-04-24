class Organization < ActiveRecord::Base

  validates :full_name, :length => { :minimum => 2 }

  # ECOTree hierarchy
  include GSP::UI::Javascript::EcoTree
  make_ecotree :class_name => 'Organization', :children => 'organizations'

  # Display information
  attr_accessible :full_name, :display_name, :governing_law, :owner
  belongs_to :owner, :class_name => 'User'
  belongs_to :governing_law, :class_name => 'User'  # Using User just as a placeholder; eventually there'd be a mangeble Law object
  has_many   :users
  has_many   :organization_templates, :order => 'created_at DESC'
  after_create :set_owner, :if => lambda { |o| o.owner_id.nil? }

  # Reviews
  has_many :active_reviews,   :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at < ? AND targeted_completion_at > ?", Time.now, Time.now]
  has_many :upcoming_reviews, :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at > ? AND targeted_completion_at > ?", Time.now, Time.now]
  has_many :past_due_reviews, :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at < ? AND targeted_completion_at < ?", Time.now, Time.now]
  has_many :reviews, :order => "targeted_start_at"

  # For ECOTree... should be something other than the general 'name'... JavaScript may have to be changed
  def name
    "#{full_name} (#{self.organization_templates.size.to_s})"
  end



private

  def set_owner
    update_attribute(:owner_id, parent.owner_id) unless parent.nil?
  end
end
