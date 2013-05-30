class OrganizationTemplate < ActiveRecord::Base
  # Mass-assign ids
  attr_accessible :agency_id, :gsp_template_id, :approved_by_id, :modified_by_id, :purchased_by_id, :shared_by_id, :parent_id, :root_parent_id, :organization_id
  
  # Display information
  attr_accessible :agency, :agency_display_name,
                  :description, :display_name, :frequency, :full_name,
                  :objectives, :organization, :regulatory_review_name,
                  :gsp_template
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
  make_ecotree :class_name => 'OrganizationTemplate', :children => 'organization_templates'
  
  # Recurrence schedule
  include IceCube
  serialize :schedule, Hash
  
  def tasks_array
    JSON.parse(tasks)
  end
  
  def tasks_array=(array)
    tasks = array.to_json
  end
  
  def generate_review
    review = Review.new :responsible_party => organization.owner, :frequency => frequency,
                        :name => regulatory_review_name, :organization => organization,
                        :organization_template => self, :status => GSP::STATUS::PENDING,
                        :assigned_at => Time.now, :deployed_at => Time.now,
                        :targeted_completion_at => calculate_due_date,
                        :targeted_start_at => Time.now + 1.week,
                        :schedule => schedule
    review.tasks = generate_tasks
    review
  end
  
  def deploy_review
    # Create Code
    review = generate_review
    review.save!
    review
    Notifications::Reviews.deploy(review).deliver
  end
  
  def occurs_on?(datetime)
    !schedule.empty? && Schedule.from_hash(schedule).occurs_on?(datetime)
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
      shared << OrganizationTemplate.create(attrs)
    end
    
    shared
  end
  
  # Date functions
  def self.length_of_time_to_complete_review
    30.days
  end
  
  def self.length_of_time_to_complete_task
    1.days
  end
  
  def calculate_due_date
    case frequency
    when "Annual"
      Time.now.end_of_year
    when "Quarterly"
      Time.now.end_of_quarter
    when "Monthly"
      Time.now.end_of_month
    else
      Time.now.end_of_week
    end
  end
  
private
  def generate_tasks
    _tasks = []
    start_at = Time.now
    
    JSON.parse(tasks).each_with_index do |t, i|
      _tasks << Task.new(:name => t["name"], :instructions => t["instructions"], :sequence => (i + 1), 
                         :status => GSP::STATUS::PENDING, :reviewer => organization.owner,
                         :assigned_at => Time.now,
                         :start_at => start_at,
                         :expected_completion_at => start_at)
      start_at = start_at + OrganizationTemplate.length_of_time_to_complete_task
    end
    _tasks
  end
end
