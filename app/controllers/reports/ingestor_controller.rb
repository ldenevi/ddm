class Reports::IngestorController < ApplicationController
  include ReportsHelper


  #################################################
  # Consolidated Smelters
  #
  #
  # TODO Consolidated smelters report needs to be optimized for speed
  def consolidated_smelters
    batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first

    worksheets_data = {:"All Reported Smelters" => [],
                       :"Consolidated Smelters" => [],
                       :"Rejected Entries"      => [],
                       :"Corrective Action Report" => [],
                       :"Condensed Consolidated Smelter Report" => [],
                       :"Smelter Compliance Status" => [],
                       :"CFSI-Compliant Smelter Listing" => []}

    # Custom sort order
    mineral_sort_order  = ["gold", "tin", "tantalum", "tungsten", ""]
    valid_smelter_id    = /^[1-4][A-Z]{3}[0-9]{3}$/
    valid_no_smelter_id = ["not listed", "not supplied", "unknown"]  # Also used as a sort order for "All Rejected Entries" worksheet

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
                                          (smelter.facility_location_country.empty? ? "ZZZZZZZ" + smelter.facility_location_country.downcase : smelter.facility_location_country.downcase),
                                          (smelter.smelter_reference_list.empty? ? "ZZZZZZZ" + smelter.smelter_reference_list.downcase : smelter.smelter_reference_list.downcase)]  }

    # Rejected entries sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort COUNTRY, all empty fields last
    # 3. Sort first by "Not Listed", then "Not Supplied", finally everything else
    rejected_entries_sort = Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                                                  (smelter.facility_location_country.empty? ? "ZZZZZZZ" + smelter.facility_location_country.downcase : smelter.facility_location_country.downcase),
                                                  (valid_no_smelter_id.index(smelter.smelter_id.downcase) || 2)] }

    # Compile sorted source data
    sorted_smelters = []
    batch.individual_validation_statuses.each do |ivs|
      next if ivs.declaration.nil?
      ivs.declaration.smelter_list.each do |smelter|
        smelter.attributes.keys.each { |attr| smelter.send("#{attr}=", smelter.send(attr).to_s) }
        smelter.smelter_id = "Not Supplied" if smelter.smelter_id.to_s.empty? || smelter.smelter_id.to_s.strip.downcase == '#n/a'
        sorted_smelters << {:smelter => smelter, :template_version => ivs.template_version, :filename => ivs.filename, :declaration => ivs.declaration}
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
      if ((smelter.smelter_id.match(valid_smelter_id) || valid_no_smelter_id.include?(smelter.smelter_id.downcase)) && smelter.standard_smelter_name.downcase.to_s.strip.size > 2 && smelter.facility_location_country.strip.match(/[a-zA-Z]/) ) ||
         ((smelter.smelter_id.match(valid_smelter_id) || valid_no_smelter_id.include?(smelter.smelter_id.downcase)) && smelter.smelter_reference_list.downcase.to_s.strip.size > 2 && smelter.facility_location_country.strip.match(/[a-zA-Z]/) ) ||
         ((smelter.smelter_id.match(valid_smelter_id) || valid_no_smelter_id.include?(smelter.smelter_id.downcase)) && smelter.smelter_reference_list.downcase.to_s.strip.size > 2 && smelter.standard_smelter_name.downcase.to_s.strip.size > 2 )

        smelter_key = smelter.smelter_id.match(valid_smelter_id) ?
                        [smelter.metal, smelter.facility_location_country.downcase, smelter.smelter_id] :
                        [smelter.metal, smelter.smelter_reference_list[0...12].downcase]
        consolidated_smelters[smelter_key] = {:data => [], :declaration_filenames => [], :data_length => 0} if consolidated_smelters[smelter_key].nil?
        consolidated_smelters[smelter_key][:declaration_filenames] << data[:filename]
        row = row + [consolidated_smelters[smelter_key][:declaration_filenames].uniq.size, consolidated_smelters[smelter_key][:declaration_filenames].uniq.join(", ")]

        # Only update declaration information of same smelter (based on smelter_key), if there is more provided data
        if row[0...-2].join('').size > consolidated_smelters[smelter_key][:data_length]
          consolidated_smelters[smelter_key][:data] = row
        end
        consolidated_smelters[smelter_key][:data_length] = row[0...-2].join('').size
      # Otherwise add valid SMELTER ID rows to Rejected Enteries worksheet
      elsif smelter.smelter_id.match(valid_smelter_id) || valid_no_smelter_id.include?(smelter.smelter_id.downcase)
        worksheets_data[:"Rejected Entries"] << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name,
                                                 smelter.facility_location_country, smelter.smelter_id, data[:filename],
                                                 data[:declaration].company_name, data[:declaration].authorized_company_representative_name, data[:declaration].representative_email, data[:declaration].representative_phone,
                                                 smelter] # Add the smelter object to the last for sorting. It will be later removed
      end
    end
    rows = []
    consolidated_smelters.each { |key, val| rows << val[:data] }
    worksheets_data[:"Consolidated Smelters"] = rows
    worksheets_data[:"Rejected Entries"] = worksheets_data[:"Rejected Entries"].sort_by { |row| rejected_entries_sort.call(row.last) }
    worksheets_data[:"Rejected Entries"] = worksheets_data[:"Rejected Entries"].collect { |row| row[0...-1] } # Remove smelter object
    rows = nil
    consolidated_smelters = nil

    # Corrective Action Report
    # Resort by columns: Metal, Standard Smelter Names, Smelter Reference List, then Country
    worksheets_data[:"Corrective Action Report"] = worksheets_data[:"Consolidated Smelters"].sort_by { |row| [(mineral_sort_order.index(row[0].downcase) || 5), row[2], row[1], row[3]] }

    # Condensed Consolidated Smelters
    worksheets_data[:"Condensed Consolidated Smelter Report"] = [] # worksheets_data[:"Consolidated Smelters"].collect { |row| }

    # CFSI-Compliant Smelter Listing
    worksheets_data[:"CFSI-Compliant Smelter Listing"] = Eicc::ConfirmedSmelter.all.collect { |s| [s.metal, s.standard_smelter_id, s.smelter_name, s.locations, s.conflict_mineral_policy_url, s.invalid_at, s.created_at] }

    # Smelter Compliance Status
    added_smelter_ids = []
    compliant_smelter_ids = worksheets_data[:"CFSI-Compliant Smelter Listing"].collect { |row| row[1] }
    consolidated_smelters_by_popularity = worksheets_data[:"Consolidated Smelters"].sort_by { |r| [(mineral_sort_order.index(r[0].downcase) || 5),
                                                                                                   (r[4].match(valid_smelter_id) ? r[4] :
                                                                                                      (valid_no_smelter_id.include?(r[4].downcase) ? "YYYYYYY" + r[4] : "ZZZZZZZ" + r[4])
                                                                                                    ),
                                                                                                    (r[3].empty? ? "ZZZZZZZ" + r[3].downcase : r[3].downcase),
                                                                                                    (r[2].empty? ? "ZZZZZZZ" + r[2].downcase : r[2].downcase),
                                                                                                    r[14]
                                                                                                  ] }

    consolidated_smelters_by_popularity.each do |row|
      next unless row[4].to_s.strip.match(valid_smelter_id)
      next if added_smelter_ids.include?(row[4])
      is_confirmed = compliant_smelter_ids.include?(row[4]) ? "\u2714" : ""
      worksheets_data[:"Smelter Compliance Status"] << [is_confirmed] + row[0..4]
      added_smelter_ids << row[4]
    end


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
          "Source EICC EICC-GeSI Report File Names"],
        :column_widths => [7, 15, 35, 35, 25, 15, 25, 25, 25, 30, 20, 30, 30, 30, 40, 20, 60]}

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
          "Source EICC EICC-GeSI Report File Names"],
        :column_widths => [7, 15, 35, 35, 25, 15, 25, 25, 25, 30, 20, 30, 30, 30, 40, 20, 60]}

      worksheets << {:name => "Rejected Entries",
        :header => [
          "   #   ",
          "Metal",
          "Smelter Reference List",
          "Standard Smelter Names",
          "Smelter Facility Location Country",
          "Smelter ID",
          "Source EICC EICC-GeSI Report File Names",
          "Company Name",
          "Representative Name",
          "Representative E-Mail",
          "Representative Phone"],
        :column_widths => [7, 15, 35, 35, 25, 15, 35, 25, 25, 25, 25]}

      worksheets << {:name => "Corrective Action Report",
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
          "Source EICC EICC-GeSI Report File Names"],
        :column_widths => [7, 15, 35, 35, 25, 15, 25, 25, 25, 30, 20, 30, 30, 30, 40, 20, 60]}

      worksheets << {:name => "Smelter Compliance Status",
        :header => [
          "   #   ",
          "Status",
          "Metal",
          "Smelter Reference List",
          "Standard Smelter Names",
          "Smelter Facility Location Country",
          "Smelter ID"],
        :column_widths => [11, 11, 15, 35, 35, 25, 15]}

      worksheets << {:name => "CFSI-Compliant Smelter Listing",
        :header => [
          "   #   ",
          "Metal",
          "Standard Smelter ID",
          "Smelter Name",
          "Locations",
          "Conflict Minerals Policy URL",
          "Valid Until",
          "Last Updated"],
        :column_widths => [7, 15, 35, 40, 40, 35, 20, 20]}

      worksheet_definitions = <<-EOT
ALL REPORTED SMELTERS
All unfiltered smelters listed within every ingested declaration spreadsheets.

CONSOLIDATED SMELTERS
Attempts to remove redundant smelters by
  1) grouping entries which have the same valid Smelter ID (or Smelter ID field is "Not
     Listed", "Not Supplied" or "Unknown"), same Standard Smelter Name includes text
     greater than 2 characters, and Country has valid data;
  2) match entries by comparing Metal, Country and valid Smelter ID, if no Smelter ID
     provided, match by Metal and first 12 characters of Smelter Reference List.
  3) Display the entry that contains the most data from all fields

REJECTED ENTRIES
Entries have either a valid Smelter ID, or Smelter ID field is "Not Listed", "Not Supplied", or
"Unknown", but no valid Country and/or Standard Smelter Name.
Sorted by 1. Metal (Gold, Tin, Tantalum, Tungsten), 2. Country, 3. Smelter ID

CORRECTIVE ACTION REPORT
The Consolidated Smelters worksheet, but sorted by 1. Metal, 2. Standard Smelter Name, 3.
Smelter Reference List, 4. Country

SMELTER COMPLIANCE STATUS
The Consolidated Smelters only grouped by Smelter ID and columns are truncated to only
Metal, Standard Smelter Name, Smelter Reference List, Country and Smelter ID.
The Status field is marked with check (%s) for entries whose Smelter ID is listed in the CFSI-
Compliant Smelter Listing.
      EOT

      branding_style = nil
      header_style   = nil
      data_style     = nil
      p.workbook.styles do |styles|
        branding_style = styles.add_style(:sz => 9, :font_name => "Lucida Console", :alignment => {:horizontal => :left, :vertical => :top, :wrap_text => true})
        header_style   = styles.add_style(:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true})
        data_style     = styles.add_style(:sz => 9, :alignment => {:horizontal => :left, :vertical => :top , :wrap_text => true})
      end

      worksheets.each do |worksheet_meta|
        p.workbook.add_worksheet(:name => worksheet_meta[:name]) do |sheet|
          worksheet_header(sheet, branding_style)
          sheet.add_row(worksheet_meta[:header], :style => header_style).height = 35.0
          friendly_index = 1
          worksheets_data[worksheet_meta[:name].to_sym].each do |row|
            sheet.add_row([friendly_index] + row, :style => data_style, :types => :string, :widths => worksheet_meta[:column_widths])
            friendly_index += 1
          end
        end
      end

      p.workbook.add_worksheet(:name => "Definitions") do |sheet|
        sheet.add_row([worksheet_definitions % "\u2714"], :style => branding_style, :types => :string)
        sheet.merge_cells "A1:H20"
      end
    end

    send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_consolidated_smelters_report.gsp.xlsx"), :type => 'application/excel'
  end

  #################################################
  # Aggregated Declarations
  #
  #
  def aggregated_declarations
    batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first

    worksheets_data = {:"Aggregated Declarations" => []}
    batch.individual_validation_statuses.each do |ivs|
      next if ivs.declaration.nil?
      row = [ivs.declaration.company_name,
             ivs.declaration.declaration_scope,
             ivs.declaration.description_of_scope,
             ivs.declaration.company_unique_identifier,
             ivs.declaration.address,
             ivs.declaration.authorized_company_representative_name,
             ivs.declaration.representative_title,
             ivs.declaration.representative_email,
             ivs.declaration.representative_phone,
             ivs.declaration.completion_at.nil? ? "" : ivs.declaration.completion_at.strftime('%B %d, %Y')]
      ivs.declaration.mineral_questions[0..5].each do |mq|
        row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]
      end
      10.times do |i|
        clq = ivs.declaration.company_level_questions[i]
        row += clq.nil? ? ["",""] : [clq.answer, clq.comment]
      end
      row += [ivs.declaration.created_at.to_formatted_s(:local), ivs.filename,  ivs.declaration.template_version, ivs.status, ivs.message.gsub(/(<li>|<\/li>)/, "")]
      worksheets_data[:"Aggregated Declarations"] <<  row
    end

    # Create spreadsheet
    spreadsheet = Axlsx::Package.new do |p|
      worksheets = []

      worksheets << {:name => "Aggregated Declarations",
        :header => ["   #   ",
          "Supplier Company Name",
          "Declaration Scope",
          "Description of Scope",
          "Company Unique Identifier",
          "Address",
          "Authorized Company Representative Name",
          "Representative Title",
          "Representative E-Mail",
          "Representative Phone",
          "Date of Completion",

          # Minerals questions
          "Question 1 \n Tantalum",
          "Question 1 Comments \n Tantalum",
          "Question 1 \n Tin",
          "Question 1 Comments \n Tin",
          "Question 1 \n Gold",
          "Question 1 Comments \n Gold",
          "Question 1 \n Tungsten",
          "Question 1 Comments \n Tungsten",

          "Question 2 \n Tantalum",
          "Question 2 Comments \n Tantalum",
          "Question 2 \n Tin",
          "Question 2 Comments \n Tin",
          "Question 2 \n Gold",
          "Question 2 Comments \n Gold",
          "Question 2 \n Tungsten",
          "Question 2 Comments \n Tungsten",

          "Question 3 \n Tantalum",
          "Question 3 Comments \n Tantalum",
          "Question 3 \n Tin",
          "Question 3 Comments \n Tin",
          "Question 3 \n Gold",
          "Question 3 Comments \n Gold",
          "Question 3 \n Tungsten",
          "Question 3 Comments \n Tungsten",

          "Question 4 \n Tantalum",
          "Question 4 Comments \n Tantalum",
          "Question 4 \n Tin",
          "Question 4 Comments \n Tin",
          "Question 4 \n Gold",
          "Question 4 Comments \n Gold",
          "Question 4 \n Tungsten",
          "Question 4 Comments \n Tungsten",

          "Question 5 \n Tantalum",
          "Question 5 Comments \n Tantalum",
          "Question 5 \n Tin",
          "Question 5 Comments \n Tin",
          "Question 5 \n Gold",
          "Question 5 Comements \n Gold",
          "Question 5 \n Tungsten",
          "Question 5 Comments \n Tungsten",

          "Question 6 \n Tantalum",
          "Question 6 Comments \n Tantalum",
          "Question 6 \n Tin",
          "Question 6 Comments \n Tin",
          "Question 6 \n Gold",
          "Question 6 Comments \n Gold",
          "Question 6 \n Tungsten",
          "Question 6 Comments \n Tungsten",

          # Company Level Questions
          "Question A",
          "Question A Comments",
          "Question B",
          "Question B Comments",
          "Question C",
          "Question C Comments",
          "Question D",
          "Question D Comments",
          "Question E",
          "Question E Comments",
          "Question F",
          "Question F Comments",
          "Question G",
          "Question G Comments",
          "Question H",
          "Question H Comments",
          "Question I",
          "Question I Comments",
          "Question J",
          "Question J Comments",

          # Extra data
          "Uploaded At",
          "CM Report\nFile Name",
          "EICC-GeSI\nTemplate Version",
          "Status",
          "Issues"]}

      branding_style = nil
      header_style = nil
      data_style   = nil
      p.workbook.styles do |styles|
        branding_style = styles.add_style(:sz => 9, :font_name => "Lucida Console", :alignment => {:horizontal => :left, :vertical => :top, :wrap_text => true})
        header_style = styles.add_style(:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true})
        data_style   = styles.add_style(:sz => 9, :alignment => {:horizontal => :left, :vertical => :top , :wrap_text => true})
      end

      worksheets.each do |worksheet_meta|
        p.workbook.add_worksheet(:name => worksheet_meta[:name]) do |sheet|
          worksheet_header(sheet, branding_style)
          sheet.add_row(worksheet_meta[:header], :style => header_style).height = 35.0
          friendly_index = 1
          worksheets_data[worksheet_meta[:name].to_sym].each do |row|
            sheet.add_row([friendly_index] + row, :style => data_style, :types => :string, :widths => [6, 20, 35, 35, 20, 25, 25, 25, 25, 30, 20, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 15, 40, 30, 40, 20, 20, 20, 20, 200]).height = 40.0
            friendly_index += 1
          end
        end
      end
    end

    send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_aggregated_declarations_report.gsp.xlsx"), :type => 'application/excel'
  end

  def smelters_by_suppliers
    spreadsheet = Axlsx::Package.new do |p|
    end
    send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_smelters_by_suppliers_report.gsp.xlsx"), :type => 'application/excel'
  end
end
