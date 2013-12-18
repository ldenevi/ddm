class Eicc::DeclarationController < ApplicationController
  def index
    @validation_statuses = Eicc::BatchValidationStatus.where(:user_id => current_user)
  end

  def list
  end

  def new
    @validation_status = Eicc::BatchValidationStatus.create :status => "New", :user => current_user, :representative_email => (current_user.nil? ? nil : current_user.email)
    redirect_to :action => :show, :id => @validation_status.id
  end

  def show
    @validation_status = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user).first
  end

  def upload
    begin
      if params[:attachment]
        # TODO Temporary file storage management
        temppath = File.join('tmp', 'uploaded_files')
        FileUtils.mkdir_p(temppath)
        tempfile_path = File.join(temppath, rand(16).to_s + '_' + params[:attachment].original_filename)
        @attachment = File.open(tempfile_path, 'wb') { |f| f.write(params[:attachment].read) }

        dec = Eicc::Declaration.generate File.join(Rails.root, tempfile_path)

        FileUtils.rm(tempfile_path)

        dec.valid?
        @errors = dec.errors.inspect
        @declaration = dec
        render :template => 'eicc/declaration/errors'
      end

    end
  end


  def validate_single_eicc_spreadsheet
    successully_processed = false

    begin
      @validation_status = begin
        begin
          Eicc::BatchValidationStatus.find params[:validation_status_id]
        rescue
          Eicc::BatchValidationStatus.create :status => "Processing", :representative_email => (current_user.nil? ? nil : current_user.email)
        end
      end

      @validation_status.update_attributes(:status => "Processing")

      # FIXME This assumes all file storage is successful
      safe_filename = params[:spreadsheet].original_filename.gsub(' ', '_').gsub(/[^\w\d.-]/, '')
      @temporary_filepath = generate_temporary_filepath(safe_filename)
      @temporary_file = File.open(@temporary_filepath, 'wb') { |f| f.write(params[:spreadsheet].read) }

       # Add details to status
      @individual_validation_status = Eicc::IndividualValidationStatus.new :status => "Opening",
                                                                                :filename => params[:spreadsheet].original_filename,
                                                                                :uploaded_file_path => @temporary_filepath,
                                                                                :message => "Attempting to open spreadsheet"

      @validation_status.individual_validation_statuses << @individual_validation_status
      @validation_status.save!

      begin

        # Attempt to read and validate declaration without raising any expectations
        @declaration = Eicc::Declaration.generate File.join(@temporary_filepath)
        @declaration.save!(:validate => false)

        @individual_validation_status.update_attributes(:status => "Validating", :message => "Analyzing spreadsheet", :declaration => @declaration, :template_version => @declaration.template_version)
        if @declaration.valid?
          @individual_validation_status.update_attributes(:status => "Green",
                                                          :representative_email => @declaration.representative_email,
                                                          :company_name => @declaration.company_name,
                                                          :message => "")
        else
          # TODO Metric validations, generate clear report
          error_messages = @declaration.errors.full_messages.uniq.select { |m| m != "Mineral questions is invalid" }

          status = @declaration.errors.full_messages.join("").downcase.match("high risk").nil? ? "Validation needed" : "High Risk"
          @individual_validation_status.update_attributes(:status => status,
                                                          :representative_email => @declaration.representative_email,
                                                          :company_name => @declaration.company_name,
                                                          :message => error_messages.map { |m| "<li>#{m}</li>" }.join("\n"))
        end

        successully_processed = true


      # An exception was raised for any reason
      rescue
        @individual_validation_status.update_attributes(:status => "File not readable",
                                                        :representative_email => (@declaration.nil? ? "" : @declaration.representative_email),
                                                        :company_name =>(@declaration.nil? ? "" :  @declaration.company_name),
                                                        :message => (Eicc::Declaration.unknown_file_format % params[:spreadsheet].original_filename))
        # TODO E-Mail Leo
        successully_processed = false
      end

    ensure
      @validation_status.update_attributes(:status => "Completed")
    end

    render :json => { :success => successully_processed }
  end

  # TODO Only pull validation status of current_user
  # TODO Use a better technique instead of polling
  def show_validation_statuses
    @validation_status = Eicc::BatchValidationStatus.find params[:id]
    render :layout => false
  end

  def find_or_create_review
    @validation_status = Eicc::BatchValidationStatus.find params[:id]
    if (@validation_status.status == "Completed" && @validation_status.review.nil?) || (@validation_status.review && @validation_status.review.tasks.size != @validation_status.individual_validation_statuses.size)
      # TODO WARNING! Destroying the review may have the effect of destroying previously entered comments, if they reopen the batch process later and upload a freash Excel!!
      @validation_status.review.destroy if @validation_status.review
      @validation_status.review = @validation_status.generate_review
      @validation_status.save!
    end
    redirect_to :controller => '/review', :action => 'task_list', :id => @validation_status.review
  end

  def download_uploaded_eicc_spreadsheet
    send_file Eicc::IndividualValidationStatus.find(params[:id]).uploaded_file_path
  end

private
  def generate_temporary_filepath(filebasename)
    temppath = File.join(Rails.root, 'tmp', 'uploaded_files', 'eicc')
    FileUtils.mkdir_p(temppath)
    tempfile_path = File.join(temppath, filebasename)
  end
end
