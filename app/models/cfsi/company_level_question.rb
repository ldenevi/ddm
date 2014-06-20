class Cfsi::CompanyLevelQuestion < ActiveRecord::Base
  belongs_to :declaration
  attr_accessible :answer, :comment, :question, :sequence

  def is_unanswered?
    answer.to_s.empty?
  end
end
