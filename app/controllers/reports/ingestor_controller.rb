class Reports::IngestorController < ApplicationController
  include ReportsHelper

  def consolidated_smelters
    # Compile data
    batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first
    smelters_data = []
    declarations_by_smelter = {}

    # Custom sort order
    mineral_sort_order = ["gold", "tin", "tantalum", "tungsten", ""]
    smelter_id_sort_order = ["not listed", "not supplied"]
    custom_sort = Proc.new { |e| [(mineral_sort_order.index(e[0].to_s.downcase) || 5),
                                   (smelter_id_sort_order.include?(e[4].to_s.downcase) ? "ZZZZZZZ" + e[4].to_s : e[4].to_s),
                                   (e[3].to_s.empty? ? "ZZZZZZZ" : e[3].to_s.downcase.gsub(/[\w,.]/,'')),
                                   e[2].to_s]  }

    batch.individual_validation_statuses.each do |ivs|
      next if ivs.declaration.nil?
      ivs.declaration.smelter_list.each do |smelter|
        # Unabridged smelters
        smelters_data << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, (smelter.smelter_id.to_s.empty? ? "Not supplied" : smelter.smelter_id),
                          smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
                          smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
                          smelter.mineral_source_location, smelter.comment, ivs.template_version, ivs.filename]

        # Consolidated smelters
        smelter_key = (smelter.smelter_id.to_s.downcase.empty? || smelter.smelter_id.to_s.downcase == "not listed") ?
                        [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id] :
                        [smelter.smelter_id]
        declarations_by_smelter[smelter_key] = {:data => [], :declarations => [], :data_length => 0} if declarations_by_smelter[smelter_key].nil?
        declarations_by_smelter[smelter_key][:declarations] << ivs.filename

        row = [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, (smelter.smelter_id.to_s.empty? ? "Not supplied" : smelter.smelter_id),
               smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
               smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
               smelter.mineral_source_location, smelter.comment,
               declarations_by_smelter[smelter_key][:declarations].uniq.size,
               declarations_by_smelter[smelter_key][:declarations].uniq.join(", ")]

        # Only update declaration information of same smelter (based on smelter_key), if there is more data
        if row.join('').size > declarations_by_smelter[smelter_key][:data_length]
          declarations_by_smelter[smelter_key][:data] = row
          declarations_by_smelter[smelter_key][:data_length] = row.join('').size
        end
      end
    end


    # Create spreadsheet
    spreadsheet = Axlsx::Package.new do |p|
      # Unabridged smelters worksheet
      header = [
        "   #   ",
        "Metal",
        "Smelter Reference List",
        "Standard Smelter Names",
        "Smelter Facility Location Country",
        "Smelter ID",
        "Smelter Facility Location Street Address",
        "Smelter Facility Location City",
        "Smelter Facility Location State / Province",
        "Smelter Facility Contact Name",
        "Smelter Facility Contact Email",
        "Proposed next steps, if applicable",
        "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
        "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
        "Comments",
        "Template Version",
        "Source EICC EICC-GeSI\nReport File Name)"]

      p.workbook.add_worksheet(:name => "All Reported Smelters") do |sheet|
        worksheet_header(sheet)
        sheet.add_row(header)
        friendly_index = 1
        smelters_data.sort_by { |e| custom_sort.call(e) }.each do |data|
          sheet.add_row([friendly_index] + data)
          friendly_index += 1
        end
      end

      # Consolidated smelters worksheet
      header = [
        "   #   ",
        "Metal",
        "Smelter Reference List",
        "Standard Smelter Names",
        "Smelter Facility Location Country",
        "Smelter ID",
        "Smelter Facility Location Street Address",
        "Smelter Facility Location City",
        "Smelter Facility Location State / Province",
        "Smelter Facility Contact Name",
        "Smelter Facility Contact Email",
        "Proposed next steps, if applicable",
        "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
        "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
        "Comments",
        "Number of\nSource EICC-GeSI\nCM Report Files",
        "Source EICC EICC-GeSI\nReport File Names)"]
      p.workbook.add_worksheet(:name => "Consolidated Smelters") do |sheet|
        worksheet_header(sheet)
        sheet.add_row(header)
        friendly_index = 1
        rows = []
        declarations_by_smelter.each do |key, val|
          rows << val[:data]
        end

        rows.sort_by { |e| custom_sort.call(e) }.each do |row|
          sheet.add_row([friendly_index] + row)
          friendly_index += 1
        end
      end
    end

    send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_consolidated_smelters_report.gsp.xlsx"), :type => 'application/excel'
  end

  def aggregated_declarations
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def smelters_by_suppliers
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
