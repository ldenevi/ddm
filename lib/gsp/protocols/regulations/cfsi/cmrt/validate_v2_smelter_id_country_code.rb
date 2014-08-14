require 'csv'

module GSP::Protocols::Regulations::CFSI::CMRT::ValidateV2SmelterIdCountryCode
  def self.included(obj)
    obj.send(:cattr_accessor, :country_codes)
    obj.send(:extend, ClassMethods)
    obj.load_data_csv
    obj.send(:include, InstanceMethods)
  end

  module ClassMethods
    def data_csv_exists?
      File.exists?(File.join(File.dirname(__FILE__), 'valid_v2_smelter_id_country_codes.csv'))
    end

    def load_data_csv
      return false unless data_csv_exists?
      csv = CSV.new(File.read(File.join(File.dirname(__FILE__), 'valid_v2_smelter_id_country_codes.csv')))
      self.country_codes = csv.to_a[1..-1].collect { |row| row[1].to_s.strip }
      true
    end

  end

  module InstanceMethods
    def is_v2_smelter_id_country_code_valid?
      return false if v2_smelter_id.to_s.empty?
      self.class.country_codes.include?(v2_smelter_id[1..3].upcase)
    end
  end
end
