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
    beginMultiple
Excels
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
end
