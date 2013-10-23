class EiccReview < Review
  has_many :declaration_diligence, :class_name => 'EiccTask', :order => 'created_at'
end
