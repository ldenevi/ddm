class User < ActiveRecord::Base
  # Display information
  attr_accessible :organization, :display_name, :first_name, :last_name,
                  :phone, :profile_image
  belongs_to :organization
  belongs_to :profile_image, :class_name => 'BinaryFile'

  # Tasks
  has_many :active_tasks, :class_name => 'Task', :foreign_key => 'reviewer_id',
                          :order => 'review_id DESC, sequence ASC',
                          :conditions => { :actual_completion_at => nil, :status => GSP::STATUS::PENDING }
  has_many :recently_completed_tasks, :class_name => 'Task', :foreign_key => 'reviewer_id',
                          :order => 'actual_completion_at DESC',
                          :conditions => ["actual_completion_at > ? AND status = ?", 1.week.ago, GSP::STATUS::COMPLETED]

  # Reviews
  has_many :active_reviews,   :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at < ? AND targeted_completion_at > ?", Time.now, Time.now], :foreign_key => 'organization_id', :primary_key => 'organization_id'
  has_many :upcoming_reviews, :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at > ? AND targeted_completion_at > ?", Time.now, Time.now], :foreign_key => 'organization_id', :primary_key => 'organization_id'
  has_many :past_due_reviews, :class_name => 'Review', :readonly => true, :conditions => ["targeted_start_at < ? AND targeted_completion_at < ?", Time.now, Time.now], :foreign_key => 'organization_id', :primary_key => 'organization_id'


  # == Devise ==
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me


  def eponym
    if display_name.to_s.empty? && first_name.to_s.empty? && last_name.to_s.empty?
      email
    elsif display_name.to_s.empty? && (first_name || last_name)
      [first_name.to_s, last_name.to_s].join(' ')
    else
      display_name
    end
  end

  def can_purchase_templates?
    true #organization.owner == self
  end

  # TODO Instead of an id (which could be any number from any model), pass a GspTemplate object
  def purchase_template(template_id)
    return false unless can_purchase_templates?

    # Copy data from Template
    template = GspTemplate.find(template_id)
    OrganizationTemplate.create :agency => template.agency, :description => template.description,
                               :display_name => template.display_name, :frequency => template.frequency,
                               :full_name => template.full_name, :objectives => template.objectives,
                               :regulatory_review_name => template.regulatory_review_name,
                               :purchased_by => self, :organization => self.organization,
                               :tasks => template.tasks
  end

  def is_gsp_admin?
    # TODO: This should be replaced with a field in the database. For now, just use this...
    !(email =~ /^superadmin./).nil?
  end

  def storage_path
    File.join(Rails.root, [id, last_name, first_name].join("_").gsub(/\W/, '_'))
  end
end
