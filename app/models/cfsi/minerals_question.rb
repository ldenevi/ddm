class Cfsi::MineralsQuestion < ActiveRecord::Base
  belongs_to :declaration

  attr_accessible :gold, :gold_comment, :question, :sequence, :tantalum,
                  :tantalum_comment, :tin, :tin_comment, :tungsten, :tungsten_comment,
                  :declaration

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  def to_s
    [question,
      ["Tantalum", tantalum, tantalum_comment].join(' - '),
      ["Tin", tin, tin_comment].join(' - '),
      ["Tungsten", tungsten, tungsten_comment].join(' - '),
      ["Gold", gold, gold_comment].join(' - ')].join("\n")
  end
end
