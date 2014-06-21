class GSP::Protocols::Regulations::CFSI::Reports::Excel::ConsolidatedSmelters < Object
  attr_accessor :validations_batch
  attr_accessor :worksheets
  attr_accessor :sorted_smelters

  def initialize(validations_batch)
    self.validations_batch = validations_batch
    self.worksheets = []
    self.sorted_smelters = []
    # Compile sorted source data
    self.validations_batch.cmrt_validations.each do |val|
      next unless val.has_declaration?
      val.cmrt.declaration.mineral_smelters.each do |smelter|
        smelter.attributes.keys.each { |attr| smelter.send("#{attr}=", smelter.send(attr).to_s) }
        smelter.smelter_id = "Not Supplied" if smelter.smelter_id.to_s.empty? || smelter.smelter_id.to_s.strip.downcase == '#n/a'
        self.sorted_smelters << {:smelter => smelter, :cmrt_version => val.cmrt.version, :file_name => val.file_name, :declaration => val.cmrt.declaration}
      end
    end
    self.sorted_smelters = self.sorted_smelters.sort_by { |data| standard_sort.call(data[:smelter]) }
    self
  end

  def mineral_sort_order
    ["gold", "tin", "tantalum", "tungsten", ""]
  end

  def valid_non_smelter_id_sort_order
    ["not listed", "not supplied", "unknown"]
  end

  def is_valid_smelter_id?(smelter_id)
    smelter_id.to_s.match /^[1-4][A-Z]{3}[0-9]{3}$/
  end

  def is_valid_non_smelter_id?(non_smelter_id)
    valid_non_smelter_id_sort_order.include? non_smelter_id.to_s.downcase
  end

  def definition
<<-EOT
INGESTOR REPORTS
Green Status Pro Ingestor generated the following RCOI reports after processing your
company's supplier's CFSI Conflict Minerals Template Reports:

  1. All Reported Smelters
  2. Consolidated Smelter Report
  3. Corrective Action Report
  4. Smelter Compliance Status Report
  5. Rejected Entries Report
  6. Aggregated Declarations Report
  7. Smelters by Supplier Report
  8. Comprehensive Suppliers Validation Report

Companies rely on these reports to document their compliance with Dodd-Frank Section 1502
and to support their Form SD Conflict Minerals Report disclosures.  This suite of reports
supports audits by independent private auditors, SEC Examiners, customers and NGO special
interest groups.


1) ALL REPORTED SMELTERS
Lists all smelter entries reported by all suppliers sorted by Smelter ID, Metal, Smelter
Reference List, Standard Smelter Name and Country.  Includes responses for all columns in
the CFSI Smelter list as reported; template version; and source CFSI Report
File Name.

The All Reported Smelters Report is the central repository for all smelter-related RCOI
data delivered to the user. It is generated in Excel format to allow the user to easily
create custom reports.


2) CONSOLIDATED SMELTER REPORT
Consolidates and sorts smelters by Smelter ID.  Checks that Metal, Standard Smelter Name
and Country are the same. For smelter entries without a valid Smelter ID, consolidates
entries with matches, in sequential order, of Metal, Country and first 12 characters
entered in the Smelter Reference List. The consolidated smelter entry row displayed is
the one that a supplier submits that contains the most data in all fields.

Includes responses for all columns in the CFSI Smelter list as reported; number of
suppliers reporting the use of the smelter; and source CFSI Report File Names.
This report consolidates smelter listings and eliminates unsupportable entries,
significantly reducing the row count of the All Reported Smelter report.


3) CORRECTIVE ACTION REPORT
Groups non-duplicative supplier smelter listings reported in the Consolidated Smelters
worksheet to guide supplier validation efforts and support judgment-based consolidation.
Required due to the large number of errors and omissions (especially Smelter IDs) found
in suppliers' CFSI Conflict Minerals Reports.  Sorts smelter rows in sequence by:
1) Metal, 2) Standard Smelter Name, 3) Smelter Reference List, 4) Country.

Green Status Pro recommends reviewers read down the Standard Smelter Name column to
identify supplier reporting errors.

This report facilitates communications with suppliers who should be providing more
accurate information; supports the responsibility to not report inaccurate information
downstream; and documents the reasonableness of consolidating smelters reported without
CFSI-issued Smelter IDs.


4) SMELTER COMPLIANCE STATUS REPORT
Identifies which smelters listed in the Consolidated Smelter report have been designated
as conflict-free.  Matches the smelter IDs reported in the Consolidated Smelter report
against the current CFSI-published listing of smelters that have passed its conflict-free
audit requirements. A smelter appearing on the consolidated smelter list is dropped from
this list if its smelter ID is invalid (listed as 'not supplied,' for instance) or an
identical smelter number has already been incorporated in this list. The Status field is
marked with check (%s) for entries whose Smelter ID is listed in the then current
CFSI-Compliant Smelter Listing. The Status field  is marked with a question mark (?) for
entries whose Smelter ID is listed in the then-current CFSI-Compliant Smelter Listing,
but if there is some uncertainty about its address. The then current CFSI-Compliant
Smelter Listing is included as a separate worksheet.

The objective of Dodd-Frank Section 1502 is to encourage and assist companies in using
3TG only from smelters that are committed to acquiring their mineral stocks from
legitimate sources.  The Smelter Compliance Status report acts as a year-over-year
scorecard on how well the company is accomplishing this goal.


5) REJECTED ENTRIES
A smelter entry must have valid data in 3 of the following 5 columns to be accepted:
Metal, Smelter Reference List, Standard Smelter Names, Smelter Facility Location Country
and Smelter ID.  It lists supplier entries that are not included in the Consolidated
Smelter Report. Suppliers who are flagged on the Rejected Entries listing should be
contacted immediately.


6) AGGREGATED DECLARATIONS
Lists each supplier and its answer to each question, including comments, on the
Declaration worksheet; template version; source CFSI Report File Name; and
Ingestor-generated validation status and messages based on the declarations.

The Aggregated Declarations Report is the central repository for all supplier contact
information, compliance policies, and use of 3TGs.  Additional reports can be created
from this overarching report.


7) SMELTERS BY SUPPLIER LIST
Lists suppliers alphabetically for each supplier. Smelters are sorted by metal, smelter
reference list, standard smelter name, and country.  Includes responses for all columns
in the CFSI Smelter list as reported; template version; source CFSI Report
File Name; company contact information; date CFSI CRMT was completed; and the
answers to Question 1, "Are any of the following metals necessary to the functionality
or production of your company's products that it manufactures or contracts to
manufacture? Tantalum? Tin? Gold? Tungsten?"

This report has the same number of rows as the All Reported Smelters Report and contains
similar data.  It is a powerful tool for quickly determining which smelters are critical
to a company's operations and which companies are providing incorrect and incomplete
smelter information.


8) COMPREHENSIVE SUPPLIERS VALIDATION
Ingestor creates a virtual due diligence worksheet for each supplier that includes all
the Validation Needed messages based on the company's rules; the manager responsible for
conducting due diligence on the supplier; and a link to the supplier's CFSI CMRT.
The reviewer adds comments and files to the virtual worksheet to document the due
diligence effort.  These comments are time stamped to provide a comprehensive audit
trail and due diligence record.

The Comprehensive Suppliers Validation report is run on an interim during the RCOI
process to provide managers with the current status of their SEC-mandated due diligence
efforts and at the end of the process to provide an auditable record of the company's
supplier due diligence.  This report is published as a PDF.

EOT
  end

  def standard_sort
    # Report's default sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort COUNTRY, all empty fields last
    # 3. Standard Smelter Name, all empty fields last
    Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                          (smelter.facility_location_country.empty? ? "ZZZZZZZ" + smelter.facility_location_country.downcase : smelter.facility_location_country.downcase),
                          (smelter.standard_smelter_name.empty? ? "ZZZZZZZ" + smelter.standard_smelter_name.downcase : smelter.standard_smelter_name.downcase)]  }
  end

  def rejected_entries_sort
    # Rejected entries sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort COUNTRY, all empty fields last
    # 3. Sort first by "Not Listed", then "Not Supplied", finally everything else
    Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                          (smelter.facility_location_country.empty? ? "ZZZZZZZ" + smelter.facility_location_country.downcase : smelter.facility_location_country.downcase),
                          (is_valid_non_smelter_id?(smelter.smelter_id) || 2)] }
  end

  def all_reported_smelters
    {:name => "All Reported Smelters",
     :header => ["   #   ",
                 "Metal",
                 "Smelter Reference List",
                 "Standard Smelter Names",
                 "Smelter Facility Location Country",
                 "Smelter ID",
                 "Source of Smelter ID",
                 "Smelter Facility Location Street Address",
                 "Smelter Facility Location City",
                 "Smelter Facility Location State / Province",
                 "Smelter Facility Contact Name",
                 "Smelter Facility Contact Email",
                 "Proposed next steps, if applicable",
                 "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
                 "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
                 "Does 100% of the smelter's feedstock originate from recycled or scrap sources?",
                 "Comments",
                 "Template Version",
                 "Source Files"],
     :column_widths => [7, 15, 35, 35, 25, 25, 15, 25, 25, 25, 30, 20, 30, 30, 30, 15, 40, 20, 60],
     :data => self.sorted_smelters.collect do |data|
                smelter = data[:smelter]
                [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id, smelter.source_of_smelter_id,
                 smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
                 smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
                 smelter.mineral_source_location, smelter.is_all_smelter_feedstock_from_recycled_sources, smelter.comment, data[:cmrt_version], data[:file_name]]
              end
    }
  end

  def consolidated_smelters
    consolidated_smelters = {}
    @rejected_entries = []
    self.sorted_smelters.each do |data|
      smelter = data[:smelter]

      row = [smelter.metal, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id, smelter.source_of_smelter_id,
             smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
             smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
             smelter.mineral_source_location, smelter.comment, smelter.is_all_smelter_feedstock_from_recycled_sources]

      # Add valid rows to Consolidated worksheet
      if ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && smelter.standard_smelter_name.size > 2 && Rails.configuration.cfsi.countries.include?(smelter.facility_location_country.upcase) ) ||
         ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && Rails.configuration.cfsi.countries.include?(smelter.facility_location_country.upcase) ) ||
         ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && smelter.standard_smelter_name.size > 2 )

        smelter_key = self.is_valid_smelter_id?(smelter.smelter_id) ?
                        [smelter.metal, smelter.facility_location_country.downcase, smelter.smelter_id] :
                        (smelter.smelter_reference_list.strip.downcase == "smelter not listed" ? [smelter.metal, smelter.standard_smelter_name.downcase, smelter.facility_location_country.downcase, smelter.smelter_id] : [smelter.metal, smelter.smelter_reference_list[0...12].downcase])
        consolidated_smelters[smelter_key] = {:data => [], :declaration_filenames => [], :data_length => 0} if consolidated_smelters[smelter_key].nil?
        consolidated_smelters[smelter_key][:declaration_filenames] << data[:file_name]
        row = row + [consolidated_smelters[smelter_key][:declaration_filenames].uniq.size, consolidated_smelters[smelter_key][:declaration_filenames].uniq.join(", ")]

        # Only update declaration information of same smelter (based on smelter_key), if there is more provided data
        if row[0...-2].join('').size > consolidated_smelters[smelter_key][:data_length]
          consolidated_smelters[smelter_key][:data] = row
        end
        consolidated_smelters[smelter_key][:data_length] = row[0...-2].join('').size
      # Otherwise add valid SMELTER ID rows to Rejected Enteries worksheet
      elsif self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)
        @rejected_entries << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name,
                              smelter.facility_location_country, smelter.smelter_id, data[:filename],
                              data[:declaration].company_name, data[:declaration].authorized_company_representative_name, data[:declaration].contact_email, data[:declaration].contact_phone,
                              smelter] # Add the smelter object to the last for sorting. It will be later removed
      end
    end
    rows = []
    consolidated_smelters.each { |key, val| rows << val[:data] }

    {:name => "Consolidated Smelters",
     :header => ["   #   ",
                 "Metal",
                 "Standard Smelter Names",
                 "Smelter Facility Location Country",
                 "Smelter ID",
                 "Source of Smelter ID",
                 "Smelter Facility Location Street Address",
                 "Smelter Facility Location City",
                 "Smelter Facility Location State / Province",
                 "Smelter Facility Contact Name",
                 "Smelter Facility Contact Email",
                 "Proposed next steps, if applicable",
                 "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
                 "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap",
                 "Does 100% of the smelter's feedstock originate from recycled or scrap sources?",
                 "Comments",
                 "Number of\nSource CFSI\nCM Report Files",
                 "Source Files"],
      :column_widths => [7, 15, 35, 25, 15, 25, 25, 25, 25, 30, 20, 30, 30, 30, 15, 40, 20, 60],
      :data => rows}
  end

  def rejected_entries
    {:name => "Rejected Entries",
     :header => ["   #   ",
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
      :column_widths => [7, 15, 35, 35, 25, 15, 35, 25, 25, 25, 25],
      :data => @rejected_entries}
  end

  def cfsi_compliant_smelter_list
    {:name => "CFSI-Compliant Smelters List",
     :header => ["   #   ",
                 "Metal",
                 "Standard Smelter ID",
                 "Smelter Name",
                 "Locations",
                 "Conflict Minerals Policy URL",
                 "Valid Until",
                 "Last Updated"],
     :column_widths => [7, 15, 35, 40, 40, 35, 20, 20],
     :data => [[1,""]]}
  end

  def smelter_compliance_status
    added_smelter_ids = []
    compliant_smelter_ids = cfsi_compliant_smelter_list[:data].collect { |row| row[1] }
    consolidated_smelters_by_popularity = consolidated_smelters[:data].sort_by { |r| [(self.mineral_sort_order.index(r[0].downcase) || 5),
                                                                                       (is_valid_smelter_id?(r[4]) ? r[4] :
                                                                                          (is_valid_non_smelter_id?(r[4]) ? "YYYYYYY" + r[4] : "ZZZZZZZ" + r[4])
                                                                                        ),
                                                                                        (r[3].empty? ? "ZZZZZZZ" + r[3].downcase : r[3].downcase),
                                                                                        (r[2].empty? ? "ZZZZZZZ" + r[2].downcase : r[2].downcase),
                                                                                        r[14]
                                                                                      ] }

    rows = []
    consolidated_smelters_by_popularity.each do |row|
      next unless is_valid_smelter_id?(row[4])
      next if added_smelter_ids.include?(row[4])
      is_confirmed = begin
                       if compliant_smelter_ids.include?(row[4]) && Rails.configuration.cfsi.countries.include?(row[3].strip.upcase)
                        "\u2714"
                       elsif compliant_smelter_ids.include?(row[4]) && !Rails.configuration.cfsi.countries.include?(row[3].strip.upcase)
                        "?"
                       else
                        ""
                       end
                     end
      rows << [is_confirmed] + row[0..4]
      added_smelter_ids << row[4]
    end

    {:name => "Smelter Compliance Status",
     :header => ["   #   ",
                 "Status",
                 "Metal",
                 "Smelter Reference List",
                 "Standard Smelter Names",
                 "Smelter Facility Location Country",
                 "Smelter ID"],
     :column_widths => [11, 11, 15, 35, 35, 25, 15],
     :data => rows}
  end

  def to_excel
    self.worksheets = [all_reported_smelters,
                       consolidated_smelters,
                       rejected_entries,
                       smelter_compliance_status,
                       cfsi_compliant_smelter_list]
    spreadsheet = Axlsx::Package.new do |p|
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
          worksheet_meta[:data].each do |row|
            sheet.add_row([friendly_index] + row, :style => data_style, :types => :string, :widths => worksheet_meta[:column_widths])
            friendly_index += 1
          end
        end
      end

      p.workbook.add_worksheet(:name => "Definitions") do |sheet|
        sheet.add_row([self.definition % "\u2714"], :style => branding_style, :types => :string)
        sheet.merge_cells "A1:H200"
      end
    end
    spreadsheet
  end

  def worksheet_header(worksheet, style)
    worksheet.add_image(:image_src => File.expand_path(File.join(Rails.root, "public/images/logo.jpg"), File.dirname(__FILE__)), :noSelect => true, :noMove => true) do |image|
     image.width  = 4
     image.height = 3

     image.start_at 0, 0
     image.end_at 2, 1
    end

    worksheet.add_row(["", "",[worksheet.name,
                              "%s: %s" % ["Co.".rjust(6, ' '), 'current_user.organization.full_name'],
                              "%s: %s" % ["Date".rjust(6, ' '), Date.today],
                              "%s: %s" % ["Time".rjust(6, ' '), Time.now.strftime("%H:%M:%S")],
                              "%s: %s" % ["User".rjust(6, ' '), 'current_user.eponym']
                              ].join("\n")], :style => style).height = 65.0

    worksheet.merge_cells "A1:B1"
    worksheet.merge_cells "C1:E1"

    # Freeze pane over data rows
    worksheet.sheet_view.pane do |pane|
      pane.top_left_cell = "A3"
      pane.state = :frozen_split
      pane.y_split = 2
      pane.x_split = 0
      pane.active_pane = :bottom_right
    end
  end

  def to_s
    {:@validations_batch => self.validations_batch.to_s, :@worksheets => self.worksheets.to_s}
  end
end
