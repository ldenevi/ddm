class Cfsi::ConfirmedSmelter < ActiveRecord::Base
  attr_accessible :invalid_at, :locations, :mineral, :name, :source, :status, :v3_smelter_id
  validates :invalid_at, :locations, :mineral, :name, :source, :status, :v3_smelter_id, :presence => true
  serialize :locations, Array
end
