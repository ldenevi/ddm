class Eicc::BatchValidationStatus < Eicc::ValidationStatus
  attr_accessible :status, :user, :representative_email

  has_many :individual_validation_statuses, :foreign_key => "parent_id", :order => "created_at DESC"

  has_many :completed,  :class_name => "Eicc::IndividualValidationStatus", :conditions => ["status <> '?'", "Validating"]
  has_many :validating, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Validating" }

  has_many :accepted_individual_validation_statuses,    :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Green" }, :foreign_key => "parent_id"
  has_many :high_risk_individual_validation_statuses,   :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "High Risk" }, :foreign_key => "parent_id"
  has_many :invalid_individual_validation_statuses,     :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "Validation needed" }, :foreign_key => "parent_id"
  has_many :individual_validation_statuses_with_errors, :class_name => "Eicc::IndividualValidationStatus", :conditions => { :status => "File not readable" }, :foreign_key => "parent_id"

  belongs_to :review, :class_name => "EiccReview"
  belongs_to :declaration, :class_name => "Eicc::Declaration"

  # TODO:
  # For the first version, the review is generated AFTER the declaration processing is run.
  # The revision should create the review BEFORE the declaration processing, and the
  # tasks are generated as EICC/GeSI spreadsheets are done processing (or rejected)
  def generate_review
    review = EiccReview.new :responsible_party => self.user, :name => "EICC Declaration - #{uploaded_at.to_formatted_s(:long)}",
                              :organization => self.user.organization, :status => GSP::STATUS::ACTIVE,
                              :assigned_at => Time.now, :deployed_at => Time.now,
                              :targeted_completion_at => Time.now.end_of_year,
                              :targeted_start_at => Time.now

    self.individual_validation_statuses.each_with_index do |ivs, index|
      task = EiccTask.new(:name => ivs.filename, :instructions => (ivs.message.to_s.empty? ? "None" : ivs.message),
                            :sequence => (index + 1),
                            :status => GSP::STATUS::ACTIVE, :reviewer => self.user,
                            :assigned_at => Time.now,
                            :start_at => Time.now,
                            :expected_completion_at => Time.now.end_of_year)
      comment = Comment.new :title => ivs.filename, :body => "", :author => user
      comment.attachments << BinaryFile.generate(:filename => ivs.filename, :data => File.read(ivs.uploaded_file_path))
      task.comments << comment
      review.tasks << task
    end
    review
  end

  def export_data
    # Compile validations
    batch = self.to_xml :include => :individual_validation_statuses
    temporary_zip_filepath = File.join(Rails.root, "my.zip")

    Zip::ZipFile.open(temporary_zip_filepath, Zip::ZipFile::CREATE) do |zipfile|
      zipfile.get_output_stream("[#{self.id}] Batch.xml") { |f| f.write(batch) }
      zipfile.close

      self.individual_validation_statuses.each do |ivs|
        if ivs.declaration.nil?
          zipfile.get_output_stream("_Declaration not saved - #{ivs.filename}.xml") { |f| f.write(ivs.to_xml(:except => %w(parent_id review_id user_id created_at declaration_id id updated_id uploaded_file_path))) }
        else
          zipfile.get_output_stream("declarations/[#{ivs.declaration.id}] #{ivs.declaration.company_name}.xml") { |f| f.write(ivs.declaration.to_xml(:include => %w(mineral_questions company_level_questions smelter_list standard_smelter_names))) }
          zipfile.close
          if File.exist?(ivs.declaration.uploaded_excel.storage_path)
            zipfile.add("spreadsheets/[#{ivs.declaration.id}] #{ivs.filename}", ivs.declaration.uploaded_excel.storage_path)
          else
            zipfile.get_output_stream("spreadsheets/_Declaration source Excel missing from [#{`hostname`.strip}].error.xml") { |f| f.write(ivs.declaration.to_xml(:include => :uploaded_excel)) }
          end
        end
      end
    end
    temporary_zip_filepath
  end


end
