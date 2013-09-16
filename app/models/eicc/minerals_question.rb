class Eicc::MineralsQuestion < ActiveRecord::Base
  attr_accessible :declaration, :gold, :gold_comment, :question, :sequence, :tantalum, :tantalum_comment, :tin, :tin_comment, :tungsten, :tungsten_comment
  
  validates :sequence, :numericality => { :only_integer => true, :message => "'%{value}' is not a number" }
  validates :question, :presence => true
    
  validates_each :gold, :tantalum, :tin, :tungsten do |record, attr, value|
    record.errors.add(attr, record.error_messages[record.sequence.to_i][attr]) if value.nil? || value.empty?
  end  
  
  belongs_to :declaration, :class_name => 'Declaration'
  
  def to_s
    [question,
      ["Tantalum", tantalum, tantalum_comment].join(' - '),
      ["Tin", tin, tin_comment].join(' - '),
      ["Tungsten", tungsten, tungsten_comment].join(' - '),
      ["Gold", gold, gold_comment].join(' - ')].join("\n")
  end
  
  def error_messages
    [{:tantalum => ": You must declare if Tantalum is in use within the scope of products declared within this survey response on the Declaration tab cell D22.",
      :tin => ": You must declare if Tin is in use within the scope of products declared within this survey response on the Declaration tab cell D23.",
      :gold => ": You must declare if Gold is in use within the scope of products declared within this survey response on the Declaration tab cell D24.",
      :tungsten => ": You must declare if Tungsten is in use within the scope of products declared within this survey response on the Declaration tab cell D25."},
     {:tantalum => ": You must declare if Tantalum used within the scope of products declared within this survey response originated from the DRC or an adjoining Country on the Declaration tab cell D28.",
      :tin => ": You must declare if Tin used within the scope of products declared within this survey response originated from the DRC or an adjoining Country on the Declaration tab cell D29.",
      :gold => ": You must declare if Gold used within the scope of products declared within this survey response originated from the DRC or an adjoining Country on the Declaration tab cell D30.",
      :tungsten => ": You must declare if Tungsten used within the scope of products declared within this survey response originated from the DRC or an adjoining Country on the Declaration tab cell D31."
     },
     {:tantalum => ": You must declare if Tantalum used within the scope of products declared within this survey response originated from a recycled or scrap source on the Declaration tab cell D34.",
      :tin => ": You must declare if Tin used within the scope of products declared within this survey response originated from a recycled or scrap source on the Declaration tab cell D35.",
      :gold => ": You must declare if Gold used within the scope of products declared within this survey response originated from a recycled or scrap source on the Declaration tab cell D36.",
      :tungsten => ": You must declare if Tungsten used within the scope of products declared within this survey response originated from a recycled or scrap source on the Declaration tab cell D37."
     },
     {:tantalum => ": You must provide % of completeness of supplier's smelter information on Declaration tab cell D40.",
      :tin => ": You must provide % of completeness of supplier's smelter information on Declaration tab cell D41.",
      :gold => ": You must provide % of completeness of supplier's smelter information on Declaration tab cell D42.",
      :tungsten => ": You must provide % of completeness of supplier's smelter information on Declaration tab cell D43."
     },
     {:tantalum => ": You must declare if all smelter names have been provided in this survey response which fall under the scope of products declared within this survey response on the Declaration tab cell D46.",
      :tin => ": You must declare if all smelter names have been provided in this survey response which fall under the scope of products declared within this survey response on the Declaration tab cell D47.",
      :gold => ": You must declare if all smelter names have been provided in this survey response which fall under the scope of products declared within this survey response on the Declaration tab cell D48.",
      :tungsten => ": You must declare if all smelter names have been provided in this survey response which fall under the scope of products declared within this survey response on the Declaration tab cell D49."
     },
     {:tantalum => ": You must declare if all smelters your company and its suppliers use for Tantalum are on the Conflict-Free Smelter (CFS) list on Declaration tab cell D52.",
      :tin => ": You must declare if all smelters your company and its suppliers use for Tin are on the Conflict-Free Smelter (CFS) list on Declaration tab cell D53.",
      :gold => ": You must declare if all smelters your company and its suppliers use for Gold are on the Conflict-Free Smelter (CFS) list on Declaration tab cell D54.",
      :tungsten => ": You must declare if all smelters your company and its suppliers use for Tungsten are on the Conflict-Free Smelter (CFS) list on Declaration tab cell D55."
     }
    ]
  end
end
