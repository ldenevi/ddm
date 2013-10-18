class Eicc::ValidationStatus < ActiveRecord::Base
  validates :status, :presence => true
  
  belongs_to :user
  
  def uploaded_at
    created_at
  end
end
