class Eicc::Declaration < ActiveRecord::Base
  attr_accessible :address, :authorized_company_representative_name, :client_id,
                  :company_name, :company_unique_identifier, :completion_at,
                  :declaration_scope, :description_of_scope, :gsp_template_input_at,
                  :invalid_reasons, :language, :representative_email,
                  :representative_phone, :representative_title, :task_id, :validation_status,
                  :uploaded_excel
                  
  # FIXME Find a better way to load this file into memory
  cattr_accessor :cell_definitions
  yaml = YAML::load_file(File.join('config', 'locales', 'eicc', '2.0.3a', 'eicc.yml'))
  @@cell_definitions = yaml["eicc"]["cell_definitions"]
  
  cattr_accessor :validation_messages
  yaml = YAML::load_file(File.join('config', 'locales', 'eicc', '2.0.3a', 'eicc_messages.en.yml'))
  @@validation_messages = yaml["eicc"]["en"]
  
  validates_with Eicc::DeclarationValidator

  validates :company_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:company_name] }
  validates :declaration_scope, :presence => { :message =>  @@validation_messages[:declaration][:no_presence][:declaration_scope] }
  validates :authorized_company_representative_name, :presence => { :message => @@validation_messages[:declaration][:no_presence][:authorized_company_representative_name] }
  validates :representative_email, :presence => { :message => @@validation_messages[:declaration][:no_presence][:representative_email] }
  validates :completion_at, :presence => { :message => @@validation_messages[:declaration][:no_presence][:completion_at] }

  has_many :mineral_questions, :class_name => Eicc::MineralsQuestion
  has_many :company_level_questions, :class_name => Eicc::CompanyLevelQuestion
  has_many :smelter_list, :class_name => Eicc::SmelterList
  has_many :standard_smelter_names, :class_name => Eicc::StandardSmelterName
  
  has_one  :uploaded_excel,  :as => :attachable, :class_name => Spreadsheet
  attr_accessor :csv_worksheets
  has_one  :csv_declaration, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_smelter_list, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_standard_smelter_names, :as => :attachable, :class_name => BinaryFile
  
  require 'fileutils'
  require 'digest/md5'
  require 'csv'
  
  def self.generate(excel_filepath)
    obj = new :uploaded_excel => BinaryFile.generate({:filename => File.basename(excel_filepath), :data => File.read(excel_filepath)})
    gnumeric_csv = GSP::Eicc::Excel::Converters::Gnumeric::Gnumeric.new(excel_filepath)
    obj.csv_worksheets = gnumeric_csv.worksheets
    obj.strip_worksheets
    obj
  end
  
  def strip_worksheets
    self.csv_worksheets.each do |worksheet|
      case worksheet.filename
      when 'eicc.csv.3'
        strip_declaration(worksheet.csv)
        worksheet.csv.rewind
        strip_minerals(worksheet.csv)
        worksheet.csv.rewind
        strip_company_level_questions(worksheet.csv)
        worksheet.csv.rewind
      when 'eicc.csv.4'
        strip_smelter_list(worksheet.csv)
      when 'eicc.csv.5'
        strip_standard_smelter_names(worksheet.csv)
      end
    end
    return true
  end
  
  def self.unknown_file_format
    "Report Rejected: Respondent did not provide its Conflict Minerals Report using the EICC-GeSI Report template in Excel format"
  end
  
private
  def strip_declaration(csv)
    csv.each_with_index do |row, index|
      case index
      when @@cell_definitions["declaration"]["company_name"]["row"]
        self.company_name = row[@@cell_definitions["declaration"]["company_name"]["column"]]
        
      when @@cell_definitions["declaration"]["declaration_scope"]["row"]
        self.declaration_scope = row[@@cell_definitions["declaration"]["declaration_scope"]["column"]]
        
      when  @@cell_definitions["declaration"]["description_of_scope"]["row"]
        self.description_of_scope = row[@@cell_definitions["declaration"]["description_of_scope"]["column"]]
        
      when  @@cell_definitions["declaration"]["language"]["row"]
        self.language = "English" #  row[@@cell_definitions["declaration"]["language"]["column"]]
        
      when  @@cell_definitions["declaration"]["company_unique_identifier"]["row"]
        self.company_unique_identifier = row[@@cell_definitions["declaration"]["company_unique_identifier"]["column"]]
        
      when  @@cell_definitions["declaration"]["address"]["row"]
        self.address = row[@@cell_definitions["declaration"]["address"]["column"]]
        
      when  @@cell_definitions["declaration"]["authorized_company_representative_name"]["row"]
        self.authorized_company_representative_name = row[@@cell_definitions["declaration"]["authorized_company_representative_name"]["column"]]
        
      when  @@cell_definitions["declaration"]["representative_title"]["row"]
        self.representative_title = row[@@cell_definitions["declaration"]["representative_title"]["column"]]
        
      when  @@cell_definitions["declaration"]["representative_email"]["row"]
        self.representative_email = row[@@cell_definitions["declaration"]["representative_email"]["column"]]
        
      when  @@cell_definitions["declaration"]["representative_phone"]["row"]
        self.representative_phone = row[@@cell_definitions["declaration"]["representative_phone"]["column"]]
        
      when  @@cell_definitions["declaration"]["date_of_completion"]["row"]
        self.completion_at = row[@@cell_definitions["declaration"]["date_of_completion"]["column"]]
      end
    end
  end

  def minerals_cell_definition
    {
      :start_row => 19,
      :end_row => 55,
      :question_column => 1,
      :number_of_minerals => 4,
      :answer_column => 3,
      :comment_column => 6,
      :number_of_questions => 6
    }
  end
    
  # I hhhaaaaaate this code, but it goes...
  def strip_minerals(csv)
    rows  = csv.read
    i     = minerals_cell_definition[:start_row]
    sequence = 0
    
    while i < minerals_cell_definition[:end_row]
      question = rows[i][minerals_cell_definition[:question_column]]
      
      i += 1
      tantalum_answer  = rows[i][minerals_cell_definition[:answer_column]]
      tantalum_comment = rows[i][minerals_cell_definition[:comment_column]]
      
      i += 1
      tin_answer  = rows[i][minerals_cell_definition[:answer_column]]
      tin_comment = rows[i][minerals_cell_definition[:comment_column]]
      
      i += 1
      gold_answer  = rows[i][minerals_cell_definition[:answer_column]]
      gold_comment = rows[i][minerals_cell_definition[:comment_column]]
      
      i += 1
      tungsten_answer  = rows[i][minerals_cell_definition[:answer_column]]
      tungsten_comment = rows[i][minerals_cell_definition[:comment_column]]
      
      i += 1
      
      self.mineral_questions << Eicc::MineralsQuestion.new(:question => question, :sequence => sequence,
                                                               :tantalum => tantalum_answer, :tantalum_comment => tantalum_comment,
                                                               :tin => tin_answer, :tin_comment => tin_comment,
                                                               :gold => gold_answer, :gold_comment => gold_comment,
                                                               :tungsten => tungsten_answer, :tungsten_comment => tungsten_comment)
      sequence += 1     
    end
  end

  def company_level_questions_definition
    {
      :start_row => 57,
      :end_row => 75,
      :question_column => 1,
      :answer_column => 3,
      :comment_column => 6
    }
  end
  
  def strip_company_level_questions(csv)
    rows  = csv.read
    i     = company_level_questions_definition[:start_row]
    sequence = 0
    
    while i < company_level_questions_definition[:end_row]
      question = rows[i][company_level_questions_definition[:question_column]] || ""
      answer   = rows[i][company_level_questions_definition[:answer_column]] || ""
      comment  = rows[i][company_level_questions_definition[:comment_column]] || ""
      
      i += 2
      
      self.company_level_questions << Eicc::CompanyLevelQuestion.new(:question => question, :sequence => sequence, :answer => answer, :comment => comment)
      sequence += 1     
    end
  end
  
  # Smelter list
  def smelter_list_definition
    {
      :start_row => 3,
      :end_row => 2000,
      :metal_column => 0,
      :reference_list_column => 1,
      :standard_smelter_list_column => 2,
      :facility_location_column => 3,
      :smelter_id_column => 4,
      :facility_location_street_column => 5,
      :facility_location_city_column => 6,
      :facility_location_province_column => 7,
      :facility_contact_name_column => 8,
      :facility_contact_email_column => 9,
      :proposed_next_step_column => 10,
      :source_column => 11,
      :source_country_column => 12,
      :comment_column => 13
    }
  end
  
  def strip_smelter_list(csv)
    rows  = csv.read
    i     = smelter_list_definition[:start_row]
    sequence = 0
    
    while i < smelter_list_definition[:end_row]
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
    {
      :start_row => 2,
      :end_row => 199,
      :metal_column => 0,
      :standard_smelter_name_column => 1,
      :known_alias_column => 2,
      :facility_location_column => 3,
      :smelter_id_column => 4
    }
  end
  
  def strip_standard_smelter_names(csv)
    rows  = csv.read
    i     = standard_smelter_name_definition[:start_row]
    while i < standard_smelter_name_definition[:end_row]
      self.standard_smelter_names << Eicc::StandardSmelterName.new(:metal => rows[i][standard_smelter_name_definition[:metal_column]],
                                                                      :standard_smelter_name => rows[i][standard_smelter_name_definition[:standard_smelter_name_column]],
                                                                      :known_alias => rows[i][standard_smelter_name_definition[:known_alias_column]],
                                                                      :facility_location_country => rows[i][standard_smelter_name_definition[:facility_location_column]],
                                                                      :smelter_id => rows[i][standard_smelter_name_definition[:smelter_id_column]])
      i += 1
    end
  end
  
  def to_s
    self.attributes.inspect
  end
  
end
