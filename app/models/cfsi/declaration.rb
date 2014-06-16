class Cfsi::Declaration < ActiveRecord::Base
  extend GSP::Protocols::Regulations::CFSI::Versions

  attr_accessible :address, :authorized_company_representative_name,
                  :company_name, :company_unique_identifier, :completion_at,
                  :contact_email, :contact_phone, :contact_title,
                  :declaration_scope, :description_of_scope,
                  :language, :version

  attr_accessor :csv_worksheets

  belongs_to :cmrt
  attr_accessible :cmrt

  has_many :company_level_questions
  attr_accessible :company_level_questions

  has_many :minerals_questions
  attr_accessible :minerals_questions

  has_many :mineral_smelters
  attr_accessible :mineral_smelters

  has_many :standard_smelter_names
  attr_accessible :standard_smelter_names

  # Reference maps for seeking the data from various versions of the same file.
  # The CFSI Conflict Minerals Reporting Template has several versions being submitted.
  attr_accessor :structure
  attr_accessor :cell_definitions

  def self.generate(cmrt_csv_worksheets = [], user = nil)
    obj = new
    obj.csv_worksheets = cmrt_csv_worksheets

    # Trim revision worksheet to speed up get_version
    cmrt_csv_worksheets.first.data = cmrt_csv_worksheets.first.data[0..16000] # cmrt_csv_worksheets.first.data.index(". All rights reserved.\"")]
    obj.version = get_version(cmrt_csv_worksheets.first.data)

    logger.info "Detected version #{obj.version}"
    raise GSP::Protocols::Regulations::CFSI::CMRT::Exceptions::VersionOne if obj.version == "1.00"

    # Reading the reference maps from the hard drive every time a Declaration is created in RAM
    # creates a speed bottleneck. This performance cost will be tolerated in this version
    # of the Cfsi::Declaration until we observe in the field all the possible variations of the CMRT
    # for research purposes.
    #
    obj.structure        = YAML::load_file(File.join('config', 'cfsi', obj.version, 'structure.yml'))
    obj.cell_definitions = YAML::load_file(File.join('config', 'cfsi', obj.version, 'cell_definitions.yml'))

    validates_with Cfsi::DeclarationValidator
    obj.extract_data_from_all_worksheets
    obj
  end

  # Create Worksheets from a list of file paths
  def self.generate_from_csv_file_paths(csv_file_paths = [])
    file_paths = csv_file_paths.sort { |a,b| a.split('.').last.to_i <=> b.split('.').last.to_i }
    worksheets = []
    file_paths.each do |path|
      worksheets << GSP::Documents::MsOffice::Excel::Spreadsheet::Worksheet.load_csv(path)
    end
    generate worksheets
  end

  def extract_data_from_all_worksheets
    extract_data_from_declaration_worksheet
    extract_data_from_minerals_questions_worksheet
    extract_data_from_company_level_questions_worksheet
    extract_data_from_mineral_smelters_worksheet
    extract_data_from_standard_smelter_names_worksheet
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
      mineral = Cfsi::MineralsQuestion.new
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
      company_level_question = Cfsi::CompanyLevelQuestion.new
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

      mineral_smelter = Cfsi::MineralSmelter.new
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

      standard_smelter_name = Cfsi::StandardSmelterName.new
      structure[:fields][:smelter_names].to_a.each do |field|
        value = rows[i][cell_definitions[:standard_smelter_name][field]]
        standard_smelter_name.send("#{field.to_s}=", (value ? value.strip.force_encoding("windows-1251").encode("UTF-8") : value))
      end
      self.standard_smelter_names << standard_smelter_name
      i += 1
    end
    standard_smelter_names_worksheet.csv.rewind
  end

end
