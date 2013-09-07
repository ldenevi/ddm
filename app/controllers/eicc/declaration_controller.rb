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
        @attachment = BinaryFile.new :filename => params[:attachment].original_filename, :data => params[:attachment].read
        @attachment.save!
        dec = Eicc::Declaration.generate File.join(Rails.root, @attachment.storage_path)
        
        
        puts dec.inspect
        
        dec.valid?
        @errors = dec.errors.inspect
      end
      
    end
  end
end
