class Eicc::MineralsQuestion < ActiveRecord::Base
  attr_accessible :declaration, :gold, :gold_comment, :question, :sequence, :tantalum, :tantalum_comment, :tin, :tin_comment, :tungsten, :tungsten_comment, :risk_level
    
  belongs_to :declaration, :class_name => 'Declaration'
  
  def to_s
    [question,
      ["Tantalum", tantalum, tantalum_comment].join(' - '),
      ["Tin", tin, tin_comment].join(' - '),
      ["Tungsten", tungsten, tungsten_comment].join(' - '),
      ["Gold", gold, gold_comment].join(' - ')].join("\n")
  end
end
