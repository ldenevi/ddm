class Cfsi::ReportsController < ApplicationController
  def report_filename(name)
    [current_user.organization.name, Time.now.strftime("%Y%m%d%H%M%S"), current_user.eponym, name].join('_-_').gsub(/[^\w,\s-\.]/, '').gsub(' ', '_')
  end

  def aggregated_smelters
    batch = Cfsi::ValidationsBatch.find(params[:batch_id])
    spreadsheet = GSP::Protocols::Regulations::CFSI::Reports::Excel::AggregatedSmelters.new(batch).to_excel
    send_data spreadsheet.to_stream(false).read, :filename => report_filename("cfsi_aggregated_smelters_report.gsp.xlsx"), :type => 'application/excel'
  end

  def consolidated_smelters
    batch = Cfsi::ValidationsBatch.find(params[:batch_id])
    spreadsheet = GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters.new(batch).to_excel
    send_data spreadsheet.to_stream(false).read, :filename => report_filename("cfsi_consolidated_smelters_report.gsp.xlsx"), :type => 'application/excel'
  end
end
