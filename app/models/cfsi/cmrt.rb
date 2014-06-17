class Cfsi::Cmrt < ActiveRecord::Base
  has_one :declaration
  belongs_to :minerals_vendor
  attr_accessible :company_name, :file_extension, :file_name, :is_latest, :language, :meta_data, :representative_email, :spreadsheet, :version

  # For an unknown reason, the declaration needs to be saved before and after for the association to work
  before_save "self.declaration.save!(:validate => false)"
  after_save "self.declaration.save!(:validate => false)"

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
    # TODO: Extract spreadsheet metadata & custom properties
    # For now, use company_name until extracting metad_data is possible
    company_name
  end

  def self.generate(file_path, user = nil)
    obj = new
    obj.file_name = File.basename(file_path)
    obj.file_extension = File.extname(file_path)
    worksheets = GSP::Documents::Conversion::OfficeConvert::Excel.to_worksheets(file_path)
    obj.declaration = Cfsi::Declaration.generate(worksheets)
    obj.company_name = obj.declaration.company_name
    obj.language = obj.declaration.language
    obj.representative_email = obj.declaration.contact_email
    obj.version = obj.declaration.version
    obj
  end
end
