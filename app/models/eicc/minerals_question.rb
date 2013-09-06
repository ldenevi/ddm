class Eicc::MineralsQuestion < ActiveRecord::Base
  attr_accessible :declaration, :gold, :gold_comment, :question, :sequence, :tantalum, :tantalum_comment, :tin, :tin_comment, :tungsten, :tungsten_comment
  
  validates :sequence, :numericality => { :only_integer => true, :message => "'%{value}' is not a number" }
  validates :question, :presence => true
  validates :gold, :tantalum, :tin, :tungsten, :inclusion => { :in => ["Yes", "No", "Unknown"], :message => "'%{value}' is not either 'Yes', 'No', nor 'Unknown'" }
  
  belongs_to :declaration, :class_name => 'Declaration'
  
  def to_s
    [question,
      ["Tantalum", tantalum, tantalum_comment].join(' - '),
      ["Tin", tin, tin_comment].join(' - '),
      ["Tungsten", tungsten, tungsten_comment].join(' - '),
      ["Gold", gold, gold_comment].join(' - ')].join("\n")
  end
end
