require 'csv'

class Eicc::ConfirmedSmelter < ActiveRecord::Base
  belongs_to :user
  attr_accessible :metal, :conflict_mineral_policy_url, :invalid_at, :locations, :smelter_name, :standard_smelter_id

  def self.from_file(filepath)
    destroy_all
    csv = CSV.new(File.read(filepath))
    csv.each_with_index do |r, i|
      next if i == 0
      create(:metal => r[0],
             :standard_smelter_id => r[1],
             :smelter_name => r[2],
             :locations => r[3],
             :invalid_at => r[4],
             :conflict_mineral_policy_url => r[5])
    end
    nil
  end
end
