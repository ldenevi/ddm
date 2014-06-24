class Cfsi::CompanyLevelQuestion < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :answer, :comment, :question, :sequence

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  def is_unanswered?
    answer.to_s.empty?
  end
end
