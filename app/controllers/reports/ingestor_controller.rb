class Reports::IngestorController < ApplicationController
  def consolidated_smelters
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def aggregated_declarations
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def smelters_by_suppliers
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
