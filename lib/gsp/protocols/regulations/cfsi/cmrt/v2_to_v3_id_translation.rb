require 'csv'

module GSP::Protocols::Regulations::CFSI::CMRT::V2ToV3IdTranslation
  def self.included(obj)
    obj.send(:cattr_accessor, :translation_table)
    obj.send(:extend, ClassMethods)
    obj.load_data_csv
    obj.send(:include, InstanceMethods)
  end

  module ClassMethods
    def data_csv_exists?
      File.exists?(File.join(File.dirname(__FILE__), 'v2_to_v3_translation_data.csv'))
    end

    def load_data_csv
      return false unless data_csv_exists?
      csv = CSV.new(File.read(File.join(File.dirname(__FILE__), 'v2_to_v3_translation_data.csv')))
      self.translation_table = csv.to_a.collect { |row| row.collect { |column| column.to_s.strip } }
      true
    end

    def get_v3_smelter_id_from_v2_smelter_id(v2_smelter_id)
      v3_smelter_id = nil
      self.translation_table.each do |row|
        if row[3] == v2_smelter_id
          v3_smelter_id = row[4]
          break
        end
      end
      v3_smelter_id
    end
  end

  module InstanceMethods
    def set_v3_smelter_id_from_v2_smelter_id(args = {:force => false})
      return if v2_smelter_id.to_s.empty?
      return unless v3_smelter_id.to_s.empty? || args[:force] == true
      self.v3_smelter_id = self.class.get_v3_smelter_id_from_v2_smelter_id(self.v2_smelter_id)
    end
  end
end
