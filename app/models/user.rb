class User < ActiveRecord::Base
  # Display information
  attr_accessible :organization, :display_name, :first_name, :last_name,
                  :phone, :profile_image
  belongs_to :organization
  belongs_to :profile_image, :class_name => 'BinaryFile'
   
  has_many :active_tasks, :class_name => 'Task', :foreign_key => 'executor_id', 
                          :order => 'review_id DESC, sequence ASC',
                          :conditions => { :actual_completion_at => nil, :status => GSP::STATUS::PENDING }
  has_many :recently_completed_tasks, :class_name => 'Task', :foreign_key => 'executor_id', 
                          :order => 'actual_completion_at DESC',
                          :conditions => ["actual_completion_at > ? AND status = ?", 1.week.ago, GSP::STATUS::COMPLETED]
  
    
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
    organization.owner == self
  end
  
  def purchase_template(template_id)
    return false unless can_purchase_templates?
    
    # Copy data from Template
    template = Template.find(template_id)
    pt = PurchasedTemplate.new :agency => template.agency, :description => template.description,
                               :display_name => template.display_name, :frequency => template.frequency,
                               :full_name => template.full_name, :objectives => template.objectives,
                               :regulatory_review_name => template.regulatory_review_name,
                               :purchased_by => self, :organization => self.organization,
                               :tasks => template.tasks
    return pt.save!
  end
end
