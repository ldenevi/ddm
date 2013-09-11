class Eicc::CompanyLevelQuestion < ActiveRecord::Base
  attr_accessible :answer, :comment, :declaration_id, :question, :sequence
  
  validates :question, :presence => true
  validates :sequence, :presence => true, :numericality => { :only_integer => true, :message => "'%{value}' is not a number" }
  validates :answer,   :inclusion => { :in => ['Yes', 'No'], :message => "'%{value}' is not either 'Yes' or 'No'" }
end
