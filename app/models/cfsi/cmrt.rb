class Cfsi::Cmrt < ActiveRecord::Base
  belongs_to :declaration
  belongs_to :spreadsheet
  belongs_to :minerals_vendor
  attr_accessible :company_name, :file_extension, :file_name, :is_latest, :language, :meta_data, :representative_email, :version

  def find_minerals_vendor
    vendors = Cfsi::MineralsVendor.where("properties LIKE ?", "%:query_match_data: #{minerals_vendor_unique_identifier}%")
    if vendors.size > 1
      raise Exception, "More than one vendor found using '#{minerals_vendor_unique_identifier}'"
    else
      vendors.first
    end
  end

  def generate_minerals_vendor
    if find_minerals_vendor.nil?
      vendor = Cfsi::MineralsVendor.new :full_name => company_name, :properties => {:query_match_data => minerals_vendor_unique_identifier}
      if vendor.save
        vendor
      else
        raise Exception, vendor.errors.full_messages
      end
    else
      raise Exception, "Vendor already exists"
    end
  end

  def minerals_vendor_unique_identifier
    # For now, use company_name until extracting metad_data is possible
    company_name
  end

  def self.generate(file_path)
  end
end
