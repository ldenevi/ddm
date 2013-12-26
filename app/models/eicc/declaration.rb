class Eicc::Declaration < ActiveRecord::Base
  extend GSP::Eicc::Versions

  attr_accessible :address, :authorized_company_representative_name, :client_id,
                  :company_name, :company_unique_identifier, :completion_at,
                  :declaration_scope, :description_of_scope, :gsp_template_input_at,
                  :invalid_reasons, :language, :representative_email,
                  :representative_phone, :representative_title, :task_id, :validation_status,
                  :uploaded_excel, :template_version

  cattr_reader :structure
  cattr_reader :cell_definitions
  cattr_reader :validation_messages

  has_many :mineral_questions, :class_name => Eicc::MineralsQuestion
  has_many :company_level_questions, :class_name => Eicc::CompanyLevelQuestion
  has_many :smelter_list, :class_name => Eicc::SmelterList
  has_many :standard_smelter_names, :class_name => Eicc::StandardSmelterName

  has_one  :uploaded_excel,  :as => :attachable, :class_name => Spreadsheet
  attr_accessor :csv_worksheets
  has_one  :csv_declaration, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_smelter_list, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_standard_smelter_names, :as => :attachable, :class_name => BinaryFile

  has_many :comments, :as => :commentable

  require 'fileutils'
  require 'digest/md5'
  require 'csv'

  def self.generate(excel_filepath, user = nil)
    gnumeric_csv = GSP::Eicc::Excel::Converters::Gnumeric::Gnumeric.new(excel_filepath)
    obj = new :uploaded_excel => Spreadsheet.generate({:filename => File.basename(excel_filepath), :data => File.read(excel_filepath), :user => user})
    obj.template_version = get_version(gnumeric_csv.worksheets.first.data)

    raise StandardError, "Old template version" if obj.template_version == "1.00"

    logger.info "Detected version #{obj.template_version}"
    obj.csv_worksheets = gnumeric_csv.worksheets

    # Fetch definitions and messages for version
    @@structure           = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'structure.yml'))
    @@cell_definitions    = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'cell_definitions.yml'))
    @@validation_messages = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'messages.en.yml'))["en"]

    # Set validation messages
    validates :company_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:company_name] }
    validates :declaration_scope, :presence => { :message =>  @@validation_messages[:declaration][:no_presence][:declaration_scope] }
    validates :authorized_company_representative_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:authorized_company_representative_name] }
    validates :representative_email, :presence => { :message => @@validation_messages[:declaration][:no_presence][:representative_email] }
    validates :completion_at, :presence => { :message => @@validation_messages[:declaration][:no_presence][:completion_at] }
    validates :language, :inclusion => { :in => %w{English}, :message => "(%{value}): " + @@validation_messages[:declaration][:no_presence][:language] }
    validates_with Eicc::DeclarationValidator

    obj.strip_worksheets
    obj
  end

  def strip_worksheets
    self.csv_worksheets.each do |worksheet|
      if worksheet.filename == "eicc.csv.#{@@structure[:worksheet_indices][:declaration]}"
        strip_declaration(worksheet.csv)
        worksheet.csv.rewind
      end
      if worksheet.filename == "eicc.csv.#{@@structure[:worksheet_indices][:minerals]}"
        strip_minerals(worksheet.csv)
        worksheet.csv.rewind
      end
      if worksheet.filename == "eicc.csv.#{@@structure[:worksheet_indices][:company_level]}"
        strip_company_level_questions(worksheet.csv)
        worksheet.csv.rewind
      end
      if worksheet.filename == "eicc.csv.#{@@structure[:worksheet_indices][:smelter_list]}"
        strip_smelter_list(worksheet.csv)
        worksheet.csv.rewind
      end
      if worksheet.filename == "eicc.csv.#{@@structure[:worksheet_indices][:smelter_names]}"
        strip_standard_smelter_names(worksheet.csv)
        worksheet.csv.rewind
      end
    end
    return true
  end

  def self.unknown_file_format
    "Report Rejected: Respondent did not provide its Conflict Minerals Report using the EICC-GeSI Report template in Excel format, or the EICC-GeSI template version is not 2.00 or newer"
  end

  def to_s
    self.attributes.inspect
  end

private
  def structure_fields
    @@structure[:fields]
  end

  def declaration_cell_definitions
    @@cell_definitions[:declaration]
  end

  def strip_declaration(csv)
    declaration_fields = structure_fields[:declaration].to_a
    field_rows = {}
    declaration_fields.collect { |field_name| field_rows[declaration_cell_definitions[field_name][:row]] = field_name }
    csv.each_with_index do |row, index|
      if field_rows.keys.include?(index)
        attribute = "#{field_rows[index].to_s}="
        value     = row[declaration_cell_definitions[field_rows[index]][:column]]
        self.send(attribute, value)
      end
    end
  end

  def minerals_cell_definition
    @@cell_definitions[:minerals]
  end

  def strip_minerals(csv)
    rows  = csv.read
    i     = minerals_cell_definition[:start_row]
    sequence = 0
    structure_fields[:minerals].each do |mineral_row|
      mineral = Eicc::MineralsQuestion.new
      mineral_row.each do |row|
        row.each do |attrib|
          next if attrib.nil?
          mineral.send("#{attrib}=", rows[i][minerals_cell_definition[attrib]])
        end
        i += 1
      end
      mineral.sequence = sequence
      self.mineral_questions << mineral
      sequence += 1
    end
  end

  def company_level_questions_definition
    @@cell_definitions[:company_level]
  end

  def strip_company_level_questions(csv)
    rows  = csv.read
    i     = company_level_questions_definition[:start_row]
    sequence = 0

    structure_fields[:company_level].each do |clq_row|
      company_level_question = Eicc::CompanyLevelQuestion.new
      clq_row.each do |attrib|
        next if attrib.nil?
        company_level_question.send("#{attrib}=", rows[i][company_level_questions_definition[attrib]])
      end
      i += 2
      company_level_question.sequence = sequence
      sequence += 1
      self.company_level_questions << company_level_question
    end
  end

  # Smelter list
  def smelter_list_definition
    @@cell_definitions[:smelter_list]
  end

  def strip_smelter_list(csv)
    rows  = csv.read
    i     = smelter_list_definition[:start_row]
    sequence = 0
    smelter_list_fields = structure_fields[:smelter_list].to_a

    # Version 2.00, 2.01 has diverse column positioning
    columns = smelter_list_definition.clone

    if ["2.00", "2.01"].include?(self.template_version)
      header_sample = self.csv_worksheets[4].data[0..2000]

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
         row_test.first.to_s.match(/^AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/)
        break
      end

      smelter_list_item = Eicc::SmelterList.new
      smelter_list_fields.each do |field|
        smelter_list_item.send("#{field.to_s}=", rows[i][columns[field]])
      end
      smelter_list_item.line_number = sequence
      sequence += 1
      i += 1
      self.smelter_list << smelter_list_item
    end
  end

  # Standard smelter names
  def standard_smelter_name_definition
    @@cell_definitions[:standard_smelter_name]
  end

  def strip_standard_smelter_names(csv)
    rows  = csv.read
    i     = standard_smelter_name_definition[:start_row]
    while !rows[i].nil?
     if rows[i].uniq.size < 4
        i += 1
        next
      end

      standard_smelter_name = Eicc::StandardSmelterName.new
      structure_fields[:smelter_names].to_a.each do |field|
        standard_smelter_name.send("#{field.to_s}=", rows[i][standard_smelter_name_definition[field]])
      end
      self.standard_smelter_names << standard_smelter_name
      i += 1
    end
  end


end
