class PurchasedTemplate < ActiveRecord::Base
  # Mass-assign ids
  attr_accessible :agency_id, :template_id, :approved_by_id, :modified_by_id, :purchased_by_id, :shared_by_id, :parent_id, :root_parent_id, :organization_id
  
  # Display information
  attr_accessible :agency, :agency_display_name,
                  :description, :display_name, :frequency, :full_name,
                  :objectives, :organization, :regulatory_review_name,
                  :template
  belongs_to :agency
  belongs_to :organization

  # Revisions
  attr_accessible :revision, :is_latest_revision
  
  # Tasks
  attr_accessible :tasks
  serialize       :tasks, JSON
  
  # Search filters
  attr_accessible :is_archived
  
  # Tracking
  attr_accessible :approved_by, :approved_at, :modified_by, :purchased_by,
                  :shared_by, :shared_at
  belongs_to :approved_by,  :class_name => 'User'
  belongs_to :modified_by,  :class_name => 'User'
  belongs_to :purchased_by, :class_name => 'User'
  belongs_to :shared_by,    :class_name => 'User'
  
  # ECOTree hierarchy
  include GSP::UI::Javascript::EcoTree
  make_ecotree :class_name => 'PurchasedTemplate', :children => 'purchased_templates'
  
  def generate_review
    review = Review.new :owner => organization.owner, :frequency => frequency,
                        :name => regulatory_review_name, :organization => organization,
                        :purchased_template => self, :status => GSP::STATUS::PENDING,
                        :assigned_at => Time.now, :deployed_at => Time.now
    review.tasks = generate_tasks
    review
  end
  
  def deploy_review
    # Create Code
    review = generate_review
    review.save!
    review
  end
  
  def deploy_all_reviews
    self.deploy_review
    self.children.each do |sub_pt|
      puts sub_pt.deploy_review.inspect
    end
  end
  
  def name
    regulatory_review_name
  end
  
  def share_among(organizations)
  
    if organizations == :all
      organizations = (self.organization.to_ecotree_array.map { |e| e[:id] })[1..-1]
    end
  
    attrs = self.attributes
    %w(id created_at updated_at organization_id).each { |k| attrs.delete(k) }
    attrs[:parent_id] = self.id
    attrs[:root_parent_id] = self.id
    attrs[:shared_at] = Time.now
    attrs[:shared_by_id] = self.organization.owner.id
    
    shared = []
    
    organizations.each do |org|
      attrs[:organization_id] = org
      shared << PurchasedTemplate.create(attrs)
    end
    
    shared
  end
  
private
  def generate_tasks
    _tasks = []
    JSON.parse(tasks).each_with_index do |t, i|
      _tasks << Task.new(:name => t["name"], :instructions => t["instructions"], :sequence => (i + 1), 
                         :status => GSP::STATUS::PENDING, :executor => organization.owner,
                         :assigned_at => Time.now)
    end
    _tasks
  end
end
