class Eicc::Declaration < ActiveRecord::Base
  attr_accessible :address, :authorized_company_representative_name, :client_id,
                  :company_name, :company_unique_identifier, :completion_at,
                  :declaration_scope, :description_of_scope, :gsp_template_input_at,
                  :invalid_reasons, :language, :representative_email,
                  :representative_phone, :representative_title, :task_id, :validation_status,
                  :uploaded_excel

  validates :authorized_company_representative_name, :client_id,
            :company_name, :completion_at,
            :declaration_scope, :gsp_template_input_at,
            :invalid_reasons, :language, :representative_email,
            :task_id, :validation_status, :presence => true
           
  has_many :mineral_questions, :class_name => Eicc::DeclarationQuestion
  has_many :company_level_questions
  
  has_one  :uploaded_excel,  :as => :attachable, :class_name => BinaryFile
  has_many :csv_worksheets,  :as => :attachable, :class_name => BinaryFile
  has_one  :csv_declaration, :as => :attachable, :class_name => BinaryFile
  has_one  :cas_smelter_list, :as => :attachable, :class_name => BinaryFile
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
      FileUtils.rm_rf @dirpath
    end
    return true
  end
  
  def strip_worksheets
    self.csv_worksheets.each do |csv|
      case csv.filename
      when 'eicc.csv.3'
        strip_declaration(csv.data)
        strip_minerals(csv.data)
      when 'eicc.csv.4'
        # TODO create Smelter's list
        # strip_smelter_list(csv.data)
        
      when 'eicc.csv.5'
        # TODO create standard smelter name
        
      end
    end
    return true
  end
  
  def self.generate(excel_filepath)
    obj = new :uploaded_excel => BinaryFile.generate(:filename => 'eicc.xls', :data => File.read(excel_filepath))
    obj.convert_to_csv
    obj.strip_worksheets
    obj
  end
  
private

  def declaration_cell_definition
    {
      :company_name => {:row => 6, :column => 3},
      :declaration_scope => {:row => 7, :column => 3},
      :description_of_scope => {:row => 8, :column => 3},
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
      
      self.mineral_questions << Eicc::DeclarationQuestion.new(:question => question, :sequence => sequence,
                                                                 :tantalum => tantalum_answer, :tantalum_comment => tantalum_comment,
                                                                 :tin => tin_answer, :tin_comment => tin_comment,
                                                                 :gold => gold_answer, :gold_comment => gold_comment,
                                                                 :tungsten => tungsten_answer, :tungsten_comment => tungsten_comment)
      sequence += 1     
    end
  end
  
  def to_s
    self.attributes.inspect
  end
  
end
