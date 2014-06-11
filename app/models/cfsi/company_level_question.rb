class Cfsi::CompanyLevelQuestion < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :answer, :comment, :question, :sequence
end
