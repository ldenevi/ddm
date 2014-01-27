class Reports::IngestorController < ApplicationController
  include ReportsHelper

  def consolidated_smelters
    batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first

    worksheets_data = {:"All Reported Smelters" => [],
                       :"Consolidated Smelters" => [],
                       :"Rejected Entries"      => [],
                       :"Invalid Entries"       => []}

    # Custom sort order
    mineral_sort_order  = ["gold", "tin", "tantalum", "tungsten", ""]
    valid_smelter_id    = /^[1-4][A-Z]{3}[0-9]{3}$/
    valid_no_smelter_id = ["not listed", "not supplied"]  # Also used as a sort order for "All Rejected Entries" worksheet

    # Report's default sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort valid SMELTER IDs, then by valid non-SMELTER IDs, finally all other data
    # 3. Alphanumerically sort COUNTRY, all empty fields last
    # 4. Smelter Reference List, all empty fields last
    standard_sort = Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                                          (smelter.smelter_id.match(valid_smelter_id) ? smelter.smelter_id :
                                            (valid_no_smelter_id.include?(smelter.smelter_id.downcase) ? "YYYYYYY" + smelter.smelter_id : "ZZZZZZZ" + smelter.smelter_id)
                                          ),
                                          (smelter.facility_location_country.empty? ? "ZZZZZZZ" : smelter.facility_location_country.downcase),
                                          (smelter.smelter_reference_list.empty? ? "ZZZZZZZ" : smelter.smelter_reference_list.downcase)]  }

    # Rejected entries sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort COUNTRY, all empty fields last
    # 3. Sort first by "Not Listed", then "Not Supplied", finally everything else
    rejected_entries_sort = Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                                                  (smelter.facility_location_country.empty? ? "ZZZZZZZ" : smelter.facility_location_country.downcase),
                                                  (valid_no_smelter_id.index(smelter.smelter_id.downcase) || 2)] }

    # Compile sorted source data
    sorted_smelters = []
    batch.individual_validation_statuses.each do |ivs|
      next if ivs.declaration.nil?
      ivs.declaration.smelter_list.each do |smelter|
        smelter.attributes.keys.each { |attr| smelter.send("#{attr}=", smelter.send(attr).to_s) }
        smelter.smelter_id = "Not Supplied" if smelter.smelter_id.to_s.empty? || smelter.smelter_id.to_s.strip.downcase == '#n/a'
        sorted_smelters << {:smelter => smelter, :template_version => ivs.template_version, :filename => ivs.filename}
      end
    end
    sorted_smelters = sorted_smelters.sort_by { |data| standard_sort.call(data[:smelter]) }


    # Compile worksheets data
    sorted_smelters.each do |data|
      smelter = data[:smelter]
      worksheets_data[:"All Reported Smelters"] << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id,
                                                    smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
                                                    smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
                                                    smelter.mineral_source_location, smelter.comment, data[:template_version], data[:filename]]
    end

    consolidated_smelters = {}
    sorted_smelters.each do |data|
      smelter = data[:smelter]

      row = [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id,
             smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
             smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
             smelter.mineral_source_location, smelter.comment]

      # Add valid rows to Consolidated worksheet
      if smelter.smelter_id.match(valid_smelter_id) || (valid_no_smelter_id.include?(smelter.smelter_id.downcase) && smelter.standard_smelter_name.downcase.to_s.strip.size > 3 && smelter.facility_location_country.strip.match(/[a-zA-Z]/) )
        smelter_key = smelter.smelter_id.match(valid_smelter_id) ?
                        [smelter.metal, smelter.facility_location_country.downcase, smelter.smelter_id] :
                        [smelter.metal, smelter.smelter_reference_list[0...12].downcase]
        consolidated_smelters[smelter_key] = {:data => [], :declaration_filenames => [], :data_length => 0} if consolidated_smelters[smelter_key].nil?
        consolidated_smelters[smelter_key][:declaration_filenames] << data[:filename]
        row = row + [consolidated_smelters[smelter_key][:declaration_filenames].uniq.size, consolidated_smelters[smelter_key][:declaration_filenames].uniq.join(", ")]

        # Only update declaration information of same smelter (based on smelter_key), if there is more provided data
        if row[0...-2].join('').size > consolidated_smelters[smelter_key][:data_length]
          consolidated_smelters[smelter_key][:data] = row
          consolidated_smelters[smelter_key][:data_length] = row[0...-2].join('').size
        end
      # Otherwise add valid SMELTER ID rows to Rejected Enteries worksheet
      elsif smelter.smelter_id.match(valid_smelter_id) || valid_no_smelter_id.include?(smelter.smelter_id.downcase)
        worksheets_data[:"Rejected Entries"] << row + [data[:filename], smelter]
      else
        worksheets_data[:"Invalid Entries"] << row + [data[:filename]]
      end
    end
    rows = []
    consolidated_smelters.each { |key, val| rows << val[:data] }
    worksheets_data[:"Consolidated Smelters"] = rows
    worksheets_data[:"Rejected Entries"] = worksheets_data[:"Rejected Entries"].sort_by { |row| rejected_entries_sort.call(row.last) }
    worksheets_data[:"Rejected Entries"] = worksheets_data[:"Rejected Entries"].collect { |row| row[0...-1] }
    rows = nil
    consolidated_smelters = nil


    # Create spreadsheet
    spreadsheet = Axlsx::Package.new do |p|
      worksheets = []

      worksheets << {:name => "All Reported Smelters",
        :header => [
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
          "Source EICC EICC-GeSI\nReport File Name)"]}

      worksheets << {:name => "Consolidated Smelters",
        :header => [
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
          "Source EICC EICC-GeSI\nReport File Names)"]}

      worksheets << {:name => "Rejected Entries",
        :header => [
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
          "Source EICC EICC-GeSI Report File Names"]}

      worksheets << {:name => "Invalid Entries",
        :header => [
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
          "Source EICC EICC-GeSI Report File Names"]}

      header_style = nil
      data_style   = nil
      p.workbook.styles do |styles|
        header_style = styles.add_style(:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true})
        data_style   = styles.add_style(:sz => 9)
      end

      worksheets.each do |worksheet_meta|
        p.workbook.add_worksheet(:name => worksheet_meta[:name]) do |sheet|
          worksheet_header(sheet)
          sheet.add_row(worksheet_meta[:header], :style => header_style).height = 35.0
          friendly_index = 1
          worksheets_data[worksheet_meta[:name].to_sym].each do |row|
            sheet.add_row([friendly_index] + row, :style => data_style, :widths => [4, 15, 35, 35, 25, 15, 25, 25, 25, 30, 20, 30, 30, 30, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 17, 20, 300])
            friendly_index += 1
          end
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
