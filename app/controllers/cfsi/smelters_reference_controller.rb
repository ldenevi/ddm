class Cfsi::SmeltersReferenceController < ApplicationController
  def list
    @smelter_references = Cfsi::Reports::SmelterReference.order(:metal).all
  end

  def update
    data = params[:csv].read.force_encoding("windows-1251").encode("UTF-8")
    csv = CSV.new(data)
    Cfsi::Reports::SmelterReference.destroy_all
    Cfsi::Reports::SmelterReference.import_from_csv(csv)
    redirect_to :action => :list
  end
end
