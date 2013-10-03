class Eicc::MineralsQuestion < ActiveRecord::Base
  attr_accessible :declaration, :gold, :gold_comment, :question, :sequence, :tantalum, :tantalum_comment, :tin, :tin_comment, :tungsten, :tungsten_comment, :risk_level
    
  attr_writer :messages
  @messages = Eicc::Declaration.validation_messages
  
  validates :sequence, :numericality => { :only_integer => true, :message => "'%{value}' is not a number" }
  validates :question, :presence => true
    
  validates_each :gold, :tantalum, :tin, :tungsten do |record, attr, value|
    next unless @messages[:minerals][record.sequence]
    record.errors.add(attr, @messages[:minerals][record.sequence][:no_presence][attr]) if value.to_s.empty?
    record.errors.add(attr, @messages[:minerals][record.sequence][:invalid_data][attr]) unless @messages[:minerals][record.sequence][:invalid_data][:expected].include?(value)
    
    case record.sequence
      when 1
        record.errors.add(attr, @messages[:minerals][record.sequence][:flagged][:is_yes][attr]) if value.to_s.downcase == "yes"
    end
  end
  
  belongs_to :declaration, :class_name => 'Declaration'
  
  def to_s
    [question,
      ["Tantalum", tantalum, tantalum_comment].join(' - '),
      ["Tin", tin, tin_comment].join(' - '),
      ["Tungsten", tungsten, tungsten_comment].join(' - '),
      ["Gold", gold, gold_comment].join(' - ')].join("\n")
  end
end
