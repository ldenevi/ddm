class Cfsi::CmrtController < ApplicationController
  def index
    @validations_batches = Cfsi::ValidationsBatch.order("created_at DESC").where(:user_id => current_user).all || []
  end

  def show
    @validations_batch = Cfsi::ValidationsBatch.where(:user_id => current_user.id).find(params[:id])
  end

  def new
    @validations_batch = Cfsi::ValidationsBatch.create :user => current_user, :organization => current_user.organization
    redirect_to :action => :show, :id => @validations_batch.id
  end

  def validate_cmrt(uploaded_cmrt_file, validations_batch_id, user = current_user)
    @validations_batch = Cfsi::ValidationsBatch.find(validations_batch_id)
    temp_file_path = store_uploaded_file(uploaded_cmrt_file)
    @validations_batch.transition_to_processing
    @cmrt_validation = Cfsi::CmrtValidation.generate(temp_file_path, :validations_batch => @validations_batch, :user => user, :organization => user.organization)
    @cmrt_validation.transition_to_opened
    @cmrt_validation.transition_to_validated
    @validations_batch.transition_to_completed
    @cmrt_validation.state != "File not readable"
  end

  def validate
    render :json => { :success => validate_cmrt(params[:spreadsheet], params[:batch_id]) }
  end

  def validate_zip
    temp_file_path = store_uploaded_file(params[:zip])
    Zip::ZipFile::open(temp_file_path) do |zip|
      temppath = File.join(Rails.root, 'tmp', 'uploaded_files', 'cfsi', rand(16).to_s, 'unzipped')
      FileUtils.mkdir_p(temppath)
      zip.each do |entry|
        if %w(.xls .xlsx).include?(File.extname(entry.name))
          filepath = File.join(temppath, File.basename(entry.name))
          zip.extract(entry, filepath)
          uploaded_simulation = ActionDispatch::Http::UploadedFile.new(:tempfile => File.new(filepath), :filename => File.basename(filepath), :content_type => 'application/vnd.ms-excel')
          uploaded_simulation.tempfile.rewind
          validate_cmrt(uploaded_simulation, params[:batch_id])
        end
      end
    end
    redirect_to :back
  end

  def list_validation_statuses
    @validations_batch = Cfsi::ValidationsBatch.where(:user_id => current_user.id).find(params[:batch_id])
    @unidentified_cmrt_validations = @validations_batch.unidentified_cmrt_validations
    @grouped_vendor_cmrt_validations = @validations_batch.grouped_vendor_cmrt_validations
    render :layout => false
  end

  def download
    send_file Cfsi::CmrtValidation.where(:user_id => current_user.id).find(params[:id]).spreadsheet.storage_path
  end

private
  def store_uploaded_file(file)
    # TODO Perhaps there is no need to save to disk. Cfsi::Cmrt.generate could simply
    # pass the file from memory over to OfficeConv.
    safe_file_name = file.original_filename.gsub(' ', '_').gsub(/[^\w\d.-]/, '')
    temp_dir_path  = File.join(Rails.root, 'tmp', 'uploaded_files', 'cfsi', 'cmrts')
    FileUtils.mkdir_p(temp_dir_path)
    temp_file_path = File.join(temp_dir_path, safe_file_name)
    File.open(temp_file_path, 'wb') { |f| f.write(file.read) }
    temp_file_path
  end
end
