class Cfsi::Product < ActiveRecord::Base
  attr_accessible :comment, :item_name, :item_number
  belongs_to :declaration

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true
end
