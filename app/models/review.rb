# TODO Remove 'owner_id' column

class Review < ActiveRecord::Base
  # Display information
  attr_accessible :frequency, :name,
                  :organization, :organization_id,
                  :responsible_party, :responsible_party_id,
                  :organization_template, :status

  belongs_to :organization
  belongs_to :responsible_party, :class_name => 'User'
  belongs_to :organization_template
  
  # Tracking
  attr_accessible :actual_completion_at, :actual_start_at,
                  :targeted_completion_at, :targeted_start_at,
                  :assigned_at, :deployed_at, :owner, :owner_id
  
  # Relationship
  attr_accessible :organization_template_id, :tasks_attributes
  has_one    :owner, :class_name => 'User'
  has_many   :comments, :order => 'created_at DESC', :as => :commentable
  
  # Tasks
  has_many   :tasks,    :order => 'sequence'
  has_many   :completed_tasks,  :class_name => 'Task', :order => 'sequence', :conditions => ["status IN (?)", [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :pending_tasks,    :class_name => 'Task', :order => 'sequence', :conditions => ["start_at > ? AND status = ?", Time.now, GSP::STATUS::TASK::INACTIVE]
  has_many   :active_tasks,     :class_name => 'Task', :order => 'sequence', :conditions => ["? > start_at AND status NOT IN (?)", Time.now, [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :incomplete_tasks, :class_name => 'Task', :order => 'sequence', :conditions => ["status NOT IN (?)", [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :non_conforming_tasks, :class_name => 'Task', :order => 'sequence', :conditions => ["status IN (?)", [GSP::STATUS::TASK::NON_CONFORMING]]
  
  has_one    :agency,   :through => :organization_template
  accepts_nested_attributes_for :tasks, :allow_destroy => true
  
  # Recurrence schedule
  attr_accessible :schedule
  serialize :schedule, Hash
  
  def initialize(args)
    super(args)
  end
  
  def progress
    (((completed_tasks.size.to_f) / tasks.size.to_f) * 100).to_i
  end
  
  def complete!
    update_attributes(:actual_completion_at => Time.now, :status => GSP::STATUS::COMPLETED)
  end
  
  def activate!
    if (Time.now > targeted_start_at && actual_completion_at == nil)
      update_attribute(:status, GSP::STATUS::ACTIVE)
    else
      false
    end
  end
  
  def is_conforming?
    non_conforming_tasks.size == 0
  end


  class << self
public
    def completed(scope = {}, current_user = nil)
      fetch(:completed, scope, current_user)
    end
    
    def in_process(scope = {}, current_user = nil)
      fetch(:in_process, scope, current_user)
    end
    
    def past_due(scope = {}, current_user = nil)
      fetch(:past_due, scope, current_user)
    end
    
    def completed_non_conforming(scope = {}, current_user = nil)
      fetch(:completed_non_conforming, scope, current_user)
    end
    
    def in_process_non_conforming(scope = {}, current_user = nil)
      fetch(:in_process_non_conforming, scope, current_user)
    end
    
    def conforming(scope = {}, current_user = nil)
      fetch(:conforming, scope, current_user)
    end
    
    def non_conforming(scope = {}, current_user = nil)
      fetch(:non_conforming, scope, current_user)
    end
    

private
    def fetch(status, scope = {}, current_user = nil)
      # Date range to be considered for display
      ago = Time.now - 12.months
      
      # Constrain reviews that will be fetched to the user's organization
      scope = begin
        case scope
          when :all
            {}
          when :by_owner
            {:responsible_party_id => current_user}
          when :in_organization
            {:organization_id => current_user.organization_id}
          else
            scope
        end
      end
      
      case status
        when :completed
          self.where(scope.merge({:actual_completion_at => ago..Time.now}))
        when :in_process
          self.where(scope.merge({:targeted_start_at => ago..Time.now, :status => GSP::STATUS::ACTIVE}))
        when :past_due
          self.where(scope.merge({:targeted_completion_at => ago..Time.now, :status => GSP::STATUS::PAST_DUE}))
        when :completed_non_conforming
          self.where(scope.merge({:actual_completion_at => ago..Time.now})).select { |review| review.non_conforming_tasks.size > 0 }
        when :in_process_non_conforming
          self.where(scope.merge({:targeted_start_at => ago..Time.now, :status => GSP::STATUS::ACTIVE})).select { |review| review.non_conforming_tasks.size > 0 }
        when :conforming
          self.where(scope.merge({:targeted_start_at => ago..Time.now})).select { |review| review.non_conforming_tasks.size == 0 }
        when :non_conforming
          self.where(scope.merge({:targeted_start_at => ago..Time.now})).select { |review| review.non_conforming_tasks.size > 0 }
          
      end
    end
    
  end
  
  
  
end
