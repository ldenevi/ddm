class Cfsi::Cmrt < ActiveRecord::Base
  has_one :declaration, :dependent => :destroy
  attr_accessible :declaration
  belongs_to :minerals_vendor
  attr_accessible :company_name, :file_extension, :file_name, :is_latest, :language, :meta_data, :representative_email, :spreadsheet, :version

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  # For an unknown reason, the declaration needs to be saved before and after for the association to work
  before_save "self.declaration.save!(:validate => false) unless self.declaration.nil?"
  after_save "self.declaration.save!(:validate => false) unless self.declaration.nil?"

  def find_minerals_vendor
    vendors = Cfsi::MineralsVendor.where("properties LIKE ?", "%:query_match_data: #{minerals_vendor_unique_identifier}%")
    if vendors.size > 1
      raise Exception, "More than one vendor found using '#{minerals_vendor_unique_identifier}'"
    else
      vendors.first
    end
  end

  def create_minerals_vendor
    if find_minerals_vendor.nil?
      vendor = Cfsi::MineralsVendor.new :name => (company_name || "Unidentified Vendor"), :properties => {:query_match_data => minerals_vendor_unique_identifier}, :organization => organization
      if vendor.save
        vendor
      else
        raise Exception, vendor.errors.full_messages
      end
    else
      raise Exception, "Vendor already exists"
    end
  end

  def find_or_create_minerals_vendor
    find_minerals_vendor || create_minerals_vendor
  end

  def minerals_vendor_unique_identifier
    # TODO: Extract spreadsheet metadata & custom properties
    # For now, use company_name until extracting metad_data is possible
    company_name || "Unidentified Vendor"
  end
  
  def initialize_attributes_from_declaration(declaration)
    self.declaration = declaration
    self.company_name = self.declaration.company_name
    self.language = self.declaration.language
    self.representative_email = self.declaration.contact_email
    self.version = self.declaration.version
    self.minerals_vendor = self.find_or_create_minerals_vendor
  end

  def self.generate(file_path, attrs = {})
    obj = new attrs.merge(:file_name => File.basename(file_path), :file_extension => File.extname(file_path))
    worksheets = GSP::Documents::Conversion::OfficeConvert::Excel.to_worksheets(file_path)
    obj.initialize_attributes_from_declaration(Cfsi::Declaration.generate(worksheets, attrs))
    obj
  end
end
