class Eicc::Declaration < ActiveRecord::Base
  attr_accessible :address, :authorized_company_representative_name, :client_id,
                  :company_name, :company_unique_identifier, :completion_at,
                  :declaration_scope, :description_of_scope, :gsp_template_input_at,
                  :invalid_reasons, :language, :representative_email,
                  :representative_phone, :representative_title, :task_id, :validation_status,
                  :uploaded_excel
                  
  # FIXME Find a better way to load this file into memory
  def self.error_messages
    @@error_messages = YAML::load_file("config/eicc_validation_error_messages.yml")
  end

  validates :client_id, :presence => true
  validates :company_name, :presence => { :message => ": You must provide your company name on the declaration tab cell D8." }
  validates :declaration_scope, :presence => { :message => ": You must determine the scope of declaration on the declaration tab cell D9." }
  validates :authorized_company_representative_name, :presence => { :message => ": You must provide Authorized Company Representative contact name in Declaration tab cell D14." }
  validates :representative_email, :presence => { :message => ": You must provide an email for Authorized Company Representative on Declaration tab cell D16." }
  validates :completion_at, :presence => { :message => ": You must provide date the form was completed on Declaration tab cell D18." }

=begin
  validates_each :language do |record, attr, value|
    record.errors.add(attr, ": For the Conflict Minerals reporting requirement, your EICC-GeSI Conflict Minerals Report, '%%' as per the SEC rules, the report must be submitted in English.  Therefore, we cannot accept this report.  Please re-submit the report in English.") if value.nil? || ["English"].include?(value)
  end 
=end 
  
  has_many :mineral_questions, :class_name => Eicc::MineralsQuestion
  has_many :company_level_questions, :class_name => Eicc::CompanyLevelQuestion
  has_many :smelter_list, :class_name => Eicc::SmelterList
  has_many :standard_smelter_names, :class_name => Eicc::StandardSmelterName
  
  has_one  :uploaded_excel,  :as => :attachable, :class_name => Spreadsheet
  has_many :csv_worksheets,  :as => :attachable, :class_name => BinaryFile
  has_one  :csv_declaration, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_smelter_list, :as => :attachable, :class_name => BinaryFile
  has_one  :csv_standard_smelter_names, :as => :attachable, :class_name => BinaryFile
  
  require 'fileutils'
  require 'digest/md5'
  require 'csv'
  
  
  def convert_to_csv
    # ./tmp/eicc_conversions/UID
    @dirpath = File.join(Rails.root, "tmp", "eicc_conversions", Digest::MD5.hexdigest(Time.now.to_s + rand.to_s))
    begin
      FileUtils.mkdir_p @dirpath
      self.uploaded_excel.save_to_filesystem!
      FileUtils.copy_file(self.uploaded_excel.storage_path, File.join(@dirpath, self.uploaded_excel.filename))
      ssconvert_output = `ssconvert -S '#{File.join(@dirpath, self.uploaded_excel.filename)}' '#{File.join(@dirpath, 'eicc.csv')}'`
      File.open(File.join(@dirpath, "ssconvert_output.txt"), 'w') { |f| f.write(ssconvert_output) }
      
      # Create worksheet objects
      Dir.glob(File.join(@dirpath, "*.csv.*")).each do |path|
        self.csv_worksheets << BinaryFile.generate(:filename => File.basename(path), :data => File.read(path)) 
      end
    ensure
      # There should be a set of CSV files outputted
      return false if Dir.glob(File.join(@dirpath, "*.csv.*")).empty?
      ## FileUtils.rm_rf @dirpath
    end
    return true
  end
  
  def strip_worksheets
    self.csv_worksheets.each do |csv|
      case csv.filename
      when 'eicc.csv.3'
        strip_declaration(csv.data)
        strip_minerals(csv.data)
        strip_company_level_questions(csv.data)
      when 'eicc.csv.4'
        strip_smelter_list(csv.data)
      when 'eicc.csv.5'
        strip_standard_smelter_names(csv.data)
      end
    end
    return true
  end
  
  def self.generate(excel_filepath)
    obj = new :uploaded_excel => BinaryFile.generate({:filename => File.basename(excel_filepath), :data => File.read(excel_filepath)})
    obj.convert_to_csv
    obj.strip_worksheets
    obj
  end
  
  
  def self.unknown_file_format
    "For the Conflict Minerals reporting requirement, your EICC-GeSI Conflict Minerals Report, '%s' does not have an xls. or .xlsx extension, or is not an Excel spreadsheet.  Therefore, our system could not read the file.  Please re-submit per EICC-GeSI instruction #8, with the file name format: companyname-date.xls (date as YYYY-DD-MM)"
  end
  
  def validate_fields
    
  end
  
  
  
private

  def declaration_cell_definition
    {
      :company_name => {:row => 6, :column => 3},
      :declaration_scope => {:row => 7, :column => 3},
      :description_of_scope => {:row => 8, :column => 3},
      :language => {:row => 1, :column => 11},
      :company_unique_identifier => {:row => 10, :column => 3},
      :address => {:row => 11, :column => 3},
      :authorized_company_representative_name => {:row => 12, :column => 3},
      :representative_title => {:row => 13, :column => 3},
      :representative_email => {:row => 14, :column => 3},
      :representative_phone => {:row => 15, :column => 3},
      :date_of_completion => {:row => 16, :column => 3}
    }
  end
    
  def strip_declaration(csv)
    CSV.new(csv).each_with_index do |row, index|
      case index
      when declaration_cell_definition[:company_name][:row]
        self.company_name = row[declaration_cell_definition[:company_name][:column]]
      when declaration_cell_definition[:declaration_scope][:row]
        self.declaration_scope = row[declaration_cell_definition[:declaration_scope][:column]]
      when declaration_cell_definition[:description_of_scope][:row]
        self.description_of_scope = row[declaration_cell_definition[:description_of_scope][:column]]
      when declaration_cell_definition[:language][:row]
        self.language = "English" # row[declaration_cell_definition[:language][:column]]
      when declaration_cell_definition[:company_unique_identifier][:row]
        self.company_unique_identifier = row[declaration_cell_definition[:company_unique_identifier][:column]]
      when declaration_cell_definition[:address][:row]
        self.address = row[declaration_cell_definition[:address][:column]]
      when declaration_cell_definition[:authorized_company_representative_name][:row]
        self.authorized_company_representative_name = row[declaration_cell_definition[:authorized_company_representative_name][:column]]
      when declaration_cell_definition[:representative_title][:row]
        self.representative_title = row[declaration_cell_definition[:representative_title][:column]]
      when declaration_cell_definition[:representative_email][:row]
        self.representative_email = row[declaration_cell_definition[:representative_email][:column]]
      when declaration_cell_definition[:representative_phone][:row]
        self.representative_phone = row[declaration_cell_definition[:representative_phone][:column]]
      when declaration_cell_definition[:date_of_completion][:row]
        self.completion_at = row[declaration_cell_definition[:date_of_completion][:column]]
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
    rows  = CSV.new(csv).read
    i     = minerals_cell_definition[:start_row]
    sequence = 0
    
    while i < minerals_cell_definition[:end_row]
      question = rows[i][minerals_cell_definition[:question_column]]
      
      i += 2
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
    rows  = CSV.new(csv).read
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
      :start_row => 9,
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
    rows  = CSV.new(csv).read
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
    rows  = CSV.new(csv).read
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
