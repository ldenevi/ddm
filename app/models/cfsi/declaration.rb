class Cfsi::Declaration < ActiveRecord::Base
  autoload :V2Validator, File.join(File.dirname(__FILE__), 'declaration_validators', 'v2_validator.rb')
  autoload :V3Validator, File.join(File.dirname(__FILE__), 'declaration_validators', 'v3_validator.rb')
  extend GSP::Protocols::Regulations::CFSI::CMRT::Versions
  include GSP::Protocols::Regulations::CFSI::CMRT::Maps
  include GSP::Protocols::Regulations::CFSI::Reports::DeclarationHelper

  attr_accessible :address, :authorized_company_representative_name,
                  :company_name, :company_unique_identifier, :completion_at,
                  :contact_email, :contact_phone, :contact_title,
                  :declaration_scope, :description_of_scope,
                  :language, :version

  attr_accessor :csv_worksheets

  belongs_to :cmrt
  attr_accessible :cmrt

  has_many :company_level_questions, :dependent => :destroy, :order => 'sequence'
  attr_accessible :company_level_questions

  has_many :minerals_questions, :dependent => :destroy, :order => 'sequence'
  attr_accessible :minerals_questions

  has_many :mineral_smelters, :dependent => :destroy
  attr_accessible :mineral_smelters

  has_many :standard_smelter_names, :dependent => :destroy
  attr_accessible :standard_smelter_names

  has_many :products, :dependent => :destroy
  attr_accessible :products

  belongs_to :organization
  attr_accessible :organization
  validates :organization, :presence => true

  # Reference maps for seeking the data from various versions of the same file.
  # The CFSI Conflict Minerals Reporting Template has several versions being submitted.
  attr_accessor :structure
  attr_accessor :cell_definitions

  def self.generate(cmrt_csv_worksheets = [], attrs = {})
    obj = new attrs
    obj.csv_worksheets = cmrt_csv_worksheets

    # Trim revision worksheet to speed up get_version
    cmrt_csv_worksheets.first.data = cmrt_csv_worksheets.first.data[0..16000] # cmrt_csv_worksheets.first.data.index(". All rights reserved.\"")]
    obj.version = get_version(cmrt_csv_worksheets.first.data)

    logger.info "Detected version #{obj.version}"
    raise GSP::Protocols::Regulations::CFSI::CMRT::Exceptions::VersionOne if obj.version == "1.00"

    obj.structure        = obj.get_structure_for_version(obj.version)
    obj.cell_definitions = obj.get_cell_definitions_for_version(obj.version)
    obj.structure[:worksheet_indices].values.uniq.each do |index|
      raise GSP::Protocols::Regulations::CFSI::CMRT::Exceptions::InvalidWorksheets if obj.csv_worksheets[index].nil?
    end

    validates_with Cfsi::Declaration::V2Validator, Cfsi::Declaration::V3Validator
    obj.extract_data_from_all_worksheets
    obj
  end

  # Create Worksheets from a list of file paths
  def self.generate_from_csv_file_paths(csv_file_paths = [], attrs = {})
    file_paths = csv_file_paths.sort { |a,b| a.split('.').last.to_i <=> b.split('.').last.to_i }
    worksheets = []
    file_paths.each do |path|
      worksheets << GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet.load_csv(path)
    end
    generate worksheets, attrs
  end

  def extract_data_from_all_worksheets
    extract_data_from_declaration_worksheet
    extract_data_from_minerals_questions_worksheet
    extract_data_from_company_level_questions_worksheet
    extract_data_from_mineral_smelters_worksheet
    # extract_data_from_standard_smelter_names_worksheet
    extract_data_from_products_worksheet
  end

  #
  # Basic declaration questions
  #
  def extract_data_from_declaration_worksheet(worksheet_index = nil)
    declaration_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:declaration]}") }.first
                                                    : self.csv_worksheets[worksheet_index]

    declaration_fields = self.structure[:fields][:declaration].to_a
    field_rows = {}
    declaration_fields.collect do |field_name|
      field_rows[cell_definitions[:declaration][field_name][:row]] = field_name
    end
    declaration_worksheet.csv.each_with_index do |row, index|
      if field_rows.keys.include?(index)
        attribute = "#{field_rows[index].to_s}="
        value     = row[cell_definitions[:declaration][field_rows[index]][:column]]
        self.send(attribute, (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
    end
    declaration_worksheet.csv.rewind
  end

  #
  # Minerals questions
  #
  def extract_data_from_minerals_questions_worksheet(worksheet_index = nil)
    minerals_questions_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:minerals]}") }.first
                                                          : self.csv_worksheets[worksheet_index]

    rows  = minerals_questions_worksheet.csv.read
    i     = cell_definitions[:minerals][:start_row]
    sequence = 0
    structure[:fields][:minerals].each do |mineral_row|
      mineral = Cfsi::MineralsQuestion.new :organization => self.organization
      mineral_row.each do |row|
        row.each do |attrib|
          next if attrib.nil?
          value = rows[i][cell_definitions[:minerals][attrib]]
          mineral.send("#{attrib}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
        end
        i += 1
      end
      mineral.sequence = sequence
      self.minerals_questions << mineral
      sequence += 1
    end
    minerals_questions_worksheet.csv.rewind
  end

  #
  # Company level questions
  #
  def extract_data_from_company_level_questions_worksheet(worksheet_index = nil)
    company_level_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:company_level]}") }.first
                                                     : self.csv_worksheets[worksheet_index]
    rows  = company_level_worksheet.csv.read
    i     = cell_definitions[:company_level][:start_row]
    sequence = 0

    structure[:fields][:company_level].each do |clq_row|
      company_level_question = Cfsi::CompanyLevelQuestion.new :organization => self.organization
      clq_row.each do |attrib|
        next if attrib.nil?
        value = rows[i][cell_definitions[:company_level][attrib]]
        company_level_question.send("#{attrib}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
      i += 2
      company_level_question.sequence = sequence
      sequence += 1
      self.company_level_questions << company_level_question
    end
    company_level_worksheet.csv.rewind
  end

  #
  # Mineral smelters list
  #
  def extract_data_from_mineral_smelters_worksheet(worksheet_index = nil)
    smelter_list_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:smelter_list]}") }.first
                                                     : self.csv_worksheets[worksheet_index]

    rows  = smelter_list_worksheet.csv.read
    i     = cell_definitions[:smelter_list][:start_row]
    sequence = 0
    smelter_list_fields = structure[:fields][:smelter_list].to_a

    # Versions have diverse column positioning
    columns = cell_definitions[:smelter_list].clone

    header_sample = self.csv_worksheets[4].data[0..2000]
    if %w(2.00 2.01).include?(self.version)
      # Shift left
      if header_sample.match("\nGold,") || header_sample.match("\nTungsten,") || header_sample.match("\nTin,") || header_sample.match("\nTantalum,")
        columns[:metal] = 0
        columns[:smelter_reference_list] = 1
        columns[:standard_smelter_name]  = 2
        columns[:facility_location_country] = 3
        columns[:facility_location_street_address] = 4
        columns[:facility_location_city] = 5
        columns[:facility_location_province] = 6
        columns[:facility_contact_name] = 7
        columns[:facility_contact_email] = 8
        columns[:proposed_next_steps] = 9
        columns[:mineral_source] = 10
        columns[:mineral_source_location] = 11
        columns[:comment] = 12
      end

    elsif %w(2.02 2.03a).include?(self.version)
      # Shift left
      if header_sample.match("\nGold,") || header_sample.match("\nTungsten,") || header_sample.match("\nTin,") || header_sample.match("\nTantalum,")
        columns[:metal] = 0
        columns[:smelter_reference_list] = 1
        columns[:standard_smelter_name] = 2
        columns[:facility_location_country] = 3
        columns[:smelter_id] = 4
        columns[:facility_location_street_address] = 5
        columns[:facility_location_city] = 6
        columns[:facility_location_province] = 7
        columns[:facility_contact_name] = 8
        columns[:facility_contact_email] = 9
        columns[:proposed_next_steps] = 10
        columns[:mineral_source] = 11
        columns[:mineral_source_location] = 12
        columns[:comment] = 13
      end
    end

    while !rows[i].nil?
      row_test = rows[i].compact

      # Skip empty row
      if row_test.empty? ||
         row_test.first.to_s == '#N/A'
        i += 1
        next
      end

      # End loop if row includes the terminal character series
      if row_test.first.to_s.match('Electronic Industry Citizenship Coalition, Incorporated and Global e-Sustainability Initiative. All rights reserved.') ||
         row_test.first.to_s.match(/^AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/) ||
         row_test.empty?
        break
      end

      mineral_smelter = Cfsi::MineralSmelter.new :organization => self.organization
      smelter_list_fields.each do |field|
        value = rows[i][columns[field]]
        value = value.split(' ').first if value && field == :metal  # value could be in the form 'Gold' or 'Gold (Au)', only take the first word
        mineral_smelter.send("#{field.to_s}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
      mineral_smelter.line_number = sequence
      sequence += 1
      i += 1
      self.mineral_smelters << mineral_smelter
    end
    smelter_list_worksheet.csv.rewind
  end

  #
  # Standard smelter names
  #
  def extract_data_from_standard_smelter_names_worksheet(worksheet_index = nil)
    standard_smelter_names_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:smelter_names]}") }.first
                                                     : self.csv_worksheets[worksheet_index]
    rows  = standard_smelter_names_worksheet.csv.read
    i     = cell_definitions[:standard_smelter_name][:start_row]
    while !rows[i].nil?
     if rows[i].uniq.size < 4
        i += 1
        next
      end

      standard_smelter_name = Cfsi::StandardSmelterName.new :organization => self.organization
      structure[:fields][:smelter_names].to_a.each do |field|
        value = rows[i][cell_definitions[:standard_smelter_name][field]]
        standard_smelter_name.send("#{field.to_s}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
      self.standard_smelter_names << standard_smelter_name
      i += 1
    end
    standard_smelter_names_worksheet.csv.rewind
  end

  #
  # Products
  #
  def extract_data_from_products_worksheet(worksheet_index = nil)
    products_worksheet = (worksheet_index.nil?) ? self.csv_worksheets.select { |w| w.file_name.match(".csv.#{self.structure[:worksheet_indices][:products]}") }.first
                                                 : self.csv_worksheets[worksheet_index]

    if products_worksheet.nil?
      self.errors.add :base, "Products List worksheet is missing in declaration spreadsheet -- 7"
      return
    end
    rows = products_worksheet.csv.read
    i    = cell_definitions[:products][:start_row]
    while !rows[i].nil?
      if rows[i].uniq.size < 3
        i += 1
        next
      end

      product = Cfsi::Product.new :organization => self.organization
      structure[:fields][:products].to_a.each do |field|
        value = rows[i][cell_definitions[:products][field]]
        product.send("#{field.to_s}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
      self.products << product
      i += 1
    end
    products_worksheet.csv.rewind
  end

end
