class Eicc::CompanyLevelQuestion < ActiveRecord::Base
  attr_accessible :answer, :comment, :declaration_id, :question, :sequence
  
  validates :question, :presence => true
  validates :sequence, :presence => true, :numericality => { :only_integer => true, :message => "'%{value}' is not a number" }
  # validates :answer,   :inclusion => { :i
  
  attr_writer :messages
  @messages = Eicc::Declaration.validation_messages
  
  validates_each :answer do |record, attr, value|
    next if @messages[:company_level][record.sequence]
    record.errors.add(attr, @messages[:company_level][record.sequence][:no_presence]) if value.to_s.empty?
    record.errors.add(attr, @messages[:company_level][record.sequence][:invalid_data][:message]) unless @messages[:company_level][record.sequence][:invalid_data][:expected].include?(value)
    
    unless [5, 8, 9].include?(record.sequence)
      record.errors.add(attr, @messages[:company_level][record.sequence][:flagged][:is_not_yes]) if value.to_s.downcase != "yes"
    end
        
    case record.sequence
      when 1
        record.errors.add(attr, @messages[:company_level][record.sequence][:flagged][:is_yes_but_no_url]) if value.to_s.downcase == "yes" && record.comment.to_s.empty?
    end
  end
end
