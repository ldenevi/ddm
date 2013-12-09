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

  def self.generate(excel_filepath)
    obj = new :uploaded_excel => BinaryFile.generate({:filename => File.basename(excel_filepath), :data => File.read(excel_filepath)})
    gnumeric_csv = GSP::Eicc::Excel::Converters::Gnumeric::Gnumeric.new(excel_filepath)
    obj.template_version = get_version(gnumeric_csv.worksheets.first.data)

    raise StandardError, "Old template version" if obj.template_version == "1.00"

    logger.info "Detected version #{obj.template_version}"
    obj.csv_worksheets = gnumeric_csv.worksheets

    # Fetch definitions and messages for version
    @@structure           = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'structure.yml'))
    @@cell_definitions    = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'cell_definitions.yml'))
    @@validation_messages = YAML::load_file(File.join('config', 'eicc', obj.template_version, 'messages.en.yml'))["en"]

    # Set validation messages
    validates_with Eicc::DeclarationValidator
    validates :company_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:company_name] }
    validates :declaration_scope, :presence => { :message =>  @@validation_messages[:declaration][:no_presence][:declaration_scope] }
    validates :authorized_company_representative_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:authorized_company_representative_name] }
    validates :representative_email, :presence => { :message => @@validation_messages[:declaration][:no_presence][:representative_email] }
    validates :completion_at, :presence => { :message => @@validation_messages[:declaration][:no_presence][:completion_at] }

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
          mineral.send("#{attr}=", rows[i][minerals_cell_definition[attrib]])
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
        company_level_question.send("#{attr}=", rows[i][company_level_questions_definition[attrib]])
      end
      i += 2
      company_level_question.sequence = sequence
      sequence += 1
      self.company_level_questions << company_level_question
    end
  end

  # Smelter list
  def smelter_list_definition
    @@cell_definitions["smelter_list"]
  end

  def strip_smelter_list(csv)
    rows  = csv.read
    i     = smelter_list_definition[:start_row]
    sequence = 0

    while !rows[i].nil?
      rows_test = rows[i].uniq
      if rows_test.size < 4
        if rows_test.size == 2 && rows_test[1].to_s.match(/^AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/)
          break
        end
        i += 1
        next
      end

      self.smelter_list << Eicc::SmelterList.new(:line_number => sequence,
                                                    :metal => rows[i][smelter_list_definition[:metal_column]],
                                                    :smelter_reference_list => rows[i][smelter_list_definition[:reference_list_column]],
                                                    :standard_smelter_name => rows[i][smelter_list_definition[:standard_smelter_list_column]],
                                                    :facility_location_country => rows[i][smelter_list_definition[:facility_location_column]],
                                                    :smelter_id => rows[i][smelter_list_definition[:smelter_id_column]],
                                                    :facility_location_street_address => rows[i][smelter_list_definition[:facility_location_street_column]],
                                                    :facility_location_city => rows[i][smelter_list_definition[:facility_location_city_column]],
                                                    :facility_location_province => rows[i][smelter_list_definition[:facility_location_province_column]],
                                                    :facility_contact_name => rows[i][smelter_list_definition[:facility_contact_name_column]],
                                                    :facility_contact_email => rows[i][smelter_list_definition[:facility_contact_email_column]],
                                                    :proposed_next_steps => rows[i][smelter_list_definition[:proposed_next_step_column]],
                                                    :mineral_source => rows[i][smelter_list_definition[:source_column]],
                                                    :mineral_source_location => rows[i][smelter_list_definition[:source_country_column]],
                                                    :comment => rows[i][smelter_list_definition[:comment_column]])
      sequence += 1
      i += 1
    end
  end

  # Standard smelter names
  def standard_smelter_name_definition
    @@cell_definitions["standard_smelter_name"]
  end

  def strip_standard_smelter_names(csv)
    rows  = csv.read
    i     = standard_smelter_name_definition[:start_row]
    while !rows[i].nil?
     if rows[i].uniq.size < 4
        i += 1
        next
      end
      self.standard_smelter_names << Eicc::StandardSmelterName.new(:metal => rows[i][standard_smelter_name_definition[:metal_column]],
                                                                      :standard_smelter_name => rows[i][standard_smelter_name_definition[:standard_smelter_name_column]],
                                                                      :known_alias => rows[i][standard_smelter_name_definition[:known_alias_column]],
                                                                      :facility_location_country => rows[i][standard_smelter_name_definition[:facility_location_column]],
                                                                      :smelter_id => rows[i][standard_smelter_name_definition[:smelter_id_column]])
      i += 1
    end
  end


end
