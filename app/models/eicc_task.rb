# An EiccTask is one supplier's declaration submission attempts, each coupled with a comment
# 

class EiccTask < Task
  has_many :declarations, :class_name => 'Eicc::Declaration', :foreign_key => 'task_id'
  belongs_to :review, :class_name => 'EiccReview'
  
  validate :reviewer, :presence => true
  validate :instructions, :presence => true
  validate :sequence, :presence => true
  validate :status, :presence => true
  validate :review, :presence => true
end
