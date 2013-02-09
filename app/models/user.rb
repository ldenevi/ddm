class User < ActiveRecord::Base
    
  # == Devise ==
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  # == GSP ==
  attr_accessible :profile_image, :phone, :language, :organization,
                  :full_name, :last_name, :display_name
  belongs_to :organization
  belongs_to :profile_image
  
  has_many :active_tasks, :class_name => 'Task', :foreign_key => 'owner_id', :conditions => { :actual_completion_at => nil, :status => GSP::STATUS::ACTIVE }
  
  def eponym
    if display_name.to_s.empty? && first_name.to_s.empty? && last_name.to_s.empty?
      email
    elsif display_name.to_s.empty? && (first_name || last_name)
      [first_name.to_s, last_name.to_s].join(' ')
    else
      display_name
    end
  end
end
