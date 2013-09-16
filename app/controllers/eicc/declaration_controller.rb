class Eicc::DeclarationController < ApplicationController
  def index
  end

  def list
  end

  def new
  end

  def show
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
    begin
      @validation_status = begin
        begin
          Eicc::ValidationStatus.find params[:validation_status_id]
        rescue
          Eicc::ValidationStatus.create :status => "Processing", :representative_email => current_user.email
        end
      end

      
      # FIXME This assumes all file storage is successful
      @temporary_filepath = generate_temporary_filepath(params[:spreadsheet].original_filename)
      @temporary_file = File.open(@temporary_filepath, 'wb') { |f| f.write(params[:spreadsheet].read) }
      
       # Add details to status
      @individual_validation_status = Eicc::IndividualValidationStatus.new :status => "Opening",
                                                                                :filename => params[:spreadsheet].original_filename,
                                                                                :uploaded_file_path => @temporary_filepath,
                                                                                :message => "Attempting to open spreadsheet"
                                                                                      
      @validation_status.individual_validation_statuses << @individual_validation_status
      @validation_status.save!

      begin                   
        @declaration = Eicc::Declaration.generate File.join(@temporary_filepath)
        
        @individual_validation_status.update_attributes(:status => "Validating", :message => "Analyzing spreadsheet")
        if @declaration.valid?
          @individual_validation_status.update_attributes(:status => "Green", :representative_email => @declaration.representative_email, :message => "")
        else
          # TODO Metric validations, generate clear report
          @individual_validation_status.update_attributes(:status => "Invalid", :representative_email => @declaration.representative_email, :message => @declaration.errors.full_messages.uniq)
        end
        
      rescue
        # TODO E-Mail Leo
        @individual_validation_status.update_attributes(:status => "Error", :representative_email => @declaration.representative_email, :message => (Eicc::Declaration[:unknown_file_format] % params[:spreadsheet].original_filename))
        @validation_status.update_attributes(:status => "Error")
      end
      

    ensure
      @validation_status.update_attributes(:status => "Completed")
    end
  end
  
private
  def generate_temporary_filepath(filebasename)
    temppath = File.join(Rails.root, 'tmp', 'uploaded_files', 'eicc')
    FileUtils.mkdir_p(temppath)
    tempfile_path = File.join(temppath, filebasename)
  end
end
