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
                  :assigned_at, :deployed_at
  
  # Relationship
  attr_accessible :organization_template_id, :tasks_attributes
  has_many   :comments, :order => 'created_at DESC', :as => :commentable
  
  # Tasks
  has_many   :tasks,    :order => 'sequence', :dependent => :destroy
  has_many   :completed_tasks,  :class_name => 'Task', :order => 'sequence', :conditions => ["status IN (?)", [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :pending_tasks,    :class_name => 'Task', :order => 'sequence', :conditions => ["start_at > ? OR status = ?", Time.now, GSP::STATUS::TASK::INACTIVE]
  has_many   :active_tasks,     :class_name => 'Task', :order => 'sequence', :conditions => ["? > start_at AND expected_completion_at > ? AND status NOT IN (?)", Time.now, Time.now, [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :incomplete_tasks, :class_name => 'Task', :order => 'sequence', :conditions => ["status NOT IN (?)", [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :non_conforming_tasks, :class_name => 'Task', :order => 'sequence', :conditions => ["status IN (?)", [GSP::STATUS::TASK::NON_CONFORMING]]
  has_many   :past_due_tasks, :class_name => 'Task', :order => 'sequence', :conditions => ["expected_completion_at < ? OR status IN (?)", Time.now, GSP::STATUS::TASK::PAST_DUE]
  
  has_one    :agency,   :through => :organization_template
  accepts_nested_attributes_for :tasks, :allow_destroy => true
  
  # Recurrence schedule
  attr_accessible :schedule
  serialize :schedule, Hash  
  
  def progress
    (((completed_tasks.size.to_f) / tasks.size.to_f) * 100).to_i
  end
  
  def complete!
    (incomplete_tasks.size == 0) ? update_attributes(:actual_completion_at => Time.now, :status => GSP::STATUS::COMPLETED) : false
  end
  
  def activate!
    (Time.now > targeted_start_at) ? update_attributes(:actual_completion_at => nil, :status => GSP::STATUS::ACTIVE) : false
  end
  
  def is_conforming?
    non_conforming_tasks.size == 0
  end
  
  def is_active?
    self.status == GSP::STATUS::ACTIVE && Time.now > targeted_start_at
  end
  
  def past_due?
    self.status == GSP::STATUS::PAST_DUE && Time.now > targeted_completion_at
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
    
    def update_all_status!
      # Active
      reviews = includes(:tasks).where("reviews.targeted_start_at < ?", Time.now)
      unless reviews.empty?
        Task.where("id IN (?)", reviews.map(&:active_tasks).flatten.map(&:id)).update_all(:status => GSP::STATUS::TASK::ACTIVE)
        Review.update_all(:status => GSP::STATUS::ACTIVE, :id => reviews.map(&:id))
      end
      
      # Past Due
      reviews = includes(:tasks).where("reviews.targeted_completion_at < ? OR (tasks.expected_completion_at < ? AND tasks.status NOT IN (?))", Time.now - 1.year, Time.now, [GSP::STATUS::TASK::CONFORMING, GSP::STATUS::TASK::NON_CONFORMING])
      unless reviews.empty?
        Task.where("id IN (?)", reviews.map(&:past_due_tasks).flatten.map(&:id)).update_all(:status => GSP::STATUS::TASK::PAST_DUE)
        Review.update_all(:status => GSP::STATUS::PAST_DUE, :id => reviews.map(&:id))
      end      
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
          self.includes(:tasks).where(scope).select { |r| r.past_due_tasks.size > 0 }
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
