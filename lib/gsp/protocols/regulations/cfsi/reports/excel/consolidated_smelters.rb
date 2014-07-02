module GSP::Protocols::Regulations::CFSI::Reports::Excel
  class ConsolidatedSmelters < Report
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

    #
    # All Reported Smelters worksheet is the list of all smelters from the a vendor's latest CMRT
    def all_reported_smelters
      {:name => "All Reported Smelters",
       :header => [{:name => "Metal", :column_width => 15},
                   {:name => "Smelter Reference List", :column_width => 35},
                   {:name => "Standard Smelter Names", :column_width => 35},
                   {:name => "Smelter Facility Location Country", :column_width => 35},
                   {:name => "Smelter ID", :column_width => 15},
                   {:name => "Source of Smelter ID", :column_width => 15},
                   {:name => "Smelter Facility Location Street Address", :column_width => 25},
                   {:name => "Smelter Facility Location City", :column_width => 25},
                   {:name => "Smelter Facility Location State / Province", :column_width => 25},
                   {:name => "Smelter Facility Contact Name", :column_width => 25},
                   {:name => "Smelter Facility Contact Email", :column_width => 25},
                   {:name => "Proposed next steps, if applicable", :column_width => 30},
                   {:name => "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap", :column_width => 35},
                   {:name => "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap", :column_width => 25},
                   {:name => "Does 100% of the smelter's feedstock originate from recycled or scrap sources?", :column_width => 15},
                   {:name => "Comments", :column_width => 45},
                   {:name => "Template Version", :column_width => 20},
                   {:name => "Source Files", :column_width => 60}],
       :data => self.sorted_smelters.collect do |data|
                  smelter = data[:smelter]
                  [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id, smelter.source_of_smelter_id,
                   smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
                   smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
                   smelter.mineral_source_location, smelter.is_all_smelter_feedstock_from_recycled_sources, smelter.comment, data[:cmrt_version], data[:file_name]]
                end
      }
    end

    def all_reported_smelters_worksheet(workbook)
      info  = all_reported_smelters
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Branding header
      worksheet_header(sheet, sheet.styles.add_style(BRANDING_STYLE))
      # Attribute name header
      sheet.add_row(['#'] + info[:header].collect { |h| h[:name] }, :style => sheet.styles.add_style(HEADER_STYLE)).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      column_widths = info[:header].collect { |h| h[:column_width]}
      info[:data].each_with_index do |row, index|
        sheet.add_row([index + 1] + row, :styles => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    #
    # Consolidated Smelters worksheet
    def consolidated_smelters
      consolidated_smelters = {}
      @rejected_entries = []
      self.sorted_smelters.each do |data|
        smelter = data[:smelter]

        row = [smelter.metal, smelter.standard_smelter_name, smelter.facility_location_country, smelter.v2_smelter_id, smelter.v3_smelter_id, smelter.source_of_smelter_id,
               smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province,
               smelter.facility_contact_name, smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source,
               smelter.mineral_source_location, smelter.comment, smelter.is_all_smelter_feedstock_from_recycled_sources]

        # Add valid rows to Consolidated worksheet
        if ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && smelter.standard_smelter_name.size > 2 && Rails.configuration.cfsi.countries.include?(smelter.facility_location_country.upcase) ) ||
           ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && Rails.configuration.cfsi.countries.include?(smelter.facility_location_country.upcase) ) ||
           ((self.is_valid_smelter_id?(smelter.smelter_id) || self.is_valid_non_smelter_id?(smelter.smelter_id)) && smelter.standard_smelter_name.size > 2 )

          smelter_key = [smelter.metal, smelter.standard_smelter_name.downcase[0..6], smelter.facility_location_country.downcase]
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
       :header => [{:name => "Metal", :column_width => 15},
                   {:name => "Standard Smelter Names", :column_width => 35},
                   {:name => "Smelter Facility Location Country", :column_width => 35},
                   {:name => "Smelter ID\nVersion 2", :column_width => 15},
                   {:name => "Smelter ID\nVersion 3", :column_width => 15},
                   {:name => "Source of Smelter ID", :column_width => 15},
                   {:name => "Smelter Facility Location Street Address", :column_width => 25},
                   {:name => "Smelter Facility Location City", :column_width => 25},
                   {:name => "Smelter Facility Location State / Province", :column_width => 25},
                   {:name => "Smelter Facility Contact Name", :column_width => 25},
                   {:name => "Smelter Facility Contact Email", :column_width => 25},
                   {:name => "Proposed next steps, if applicable", :column_width => 30},
                   {:name => "Name of Mine(s) or if recycled or scrap sourced, state recycled or scrap", :column_width => 30},
                   {:name => "Location (Country) of Mine(s) or if recycled or scrap sourced, state recycled or scrap", :column_width => 15},
                   {:name => "Does 100% of the smelter's feedstock originate from recycled or scrap sources?", :column_width => 30},
                   {:name => "Comments", :column_width => 40},
                   {:name => "Number of\nSource CFSI\nCM Report Files", :column_width => 20},
                   {:name => "Source Files", :column_width => 60}],
        :data => rows}
    end

    def consolidated_smelters_worksheet(workbook)
      info  = consolidated_smelters
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Branding header
      worksheet_header(sheet, sheet.styles.add_style(BRANDING_STYLE))
      # Attribute name header
      sheet.add_row(['#'] + info[:header].collect { |h| h[:name] }, :style => sheet.styles.add_style(HEADER_STYLE)).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      column_widths = info[:header].collect { |h| h[:column_width]}
      info[:data].each_with_index do |row, index|
        sheet.add_row([index + 1] + row, :styles => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    #
    # Rejected entries worksheet
    def rejected_entries
      raise StandardError, "#consolidated_smelters must be run before #rejected_entries" if @rejected_entries.nil?
      {:name => "Rejected Entries",
       :header => [{:name => "Metal", :column_width => 15},
                   {:name => "Smelter Reference List", :column_width => 35},
                   {:name => "Standard Smelter Names", :column_width => 35},
                   {:name => "Smelter Facility Location Country", :column_width => 35},
                   {:name => "Smelter ID", :column_width => 25},
                   {:name => "Source CFSI CMRT File Names", :column_width => 15},
                   {:name => "Company Name", :column_width => 35},
                   {:name => "Representative Name", :column_width => 25},
                   {:name => "Representative E-Mail", :column_width => 25},
                   {:name => "Representative Phone", :column_width => 25}],
        :data => @rejected_entries}
    end

    def rejected_entries_worksheet(workbook)
      info  = rejected_entries
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Branding header
      worksheet_header(sheet, sheet.styles.add_style(BRANDING_STYLE))
      # Attribute name header
      sheet.add_row(['#'] + info[:header].collect { |h| h[:name] }, :style => sheet.styles.add_style(HEADER_STYLE)).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      column_widths = info[:header].collect { |h| h[:column_width]}
      info[:data].each_with_index do |row, index|
        sheet.add_row([index + 1] + row, :styles => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    def cfsi_compliant_smelter_list
      hash_data = {}
      confirmed_smelters = Cfsi::ConfirmedSmelter.order(:created_at).all
      confirmed_smelters.each { |cs| hash_data.merge!({cs.v3_smelter_id => cs.status})  }
      data = confirmed_smelters.map { |cs| [cs.status, cs.mineral, cs.v3_smelter_id, cs.name, cs.locations.join(", "), cs.invalid_at.to_formatted_s(:short), cs.created_at.to_formatted_s(:short)] }

      {:name => "CFSI-Compliant Smelters List",
       :header => [{:name => "Status", :column_width => 15},
                   {:name => "Metal", :column_width => 15},
                   {:name => "Standard Smelter ID", :column_width => 35},
                   {:name => "Smelter Name", :column_width => 40},
                   {:name => "Locations", :column_width => 40},
                   {:name => "Valid Until", :column_width => 20},
                   {:name => "Last Updated", :column_width => 20}],
       :hash_data => hash_data,
       :data => data}
    end

    def cfsi_compliant_smelter_list_worksheet(workbook)
      info  = cfsi_compliant_smelter_list
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Attribute name header
      sheet.add_row(['#'] + info[:header].collect { |h| h[:name] }, :style => sheet.styles.add_style(HEADER_STYLE)).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      column_widths = info[:header].collect { |h| h[:column_width]}
      info[:data].each_with_index do |row, index|
        sheet.add_row([index + 1] + row, :styles => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    #
    # Smelter Compliance Statuses
    def smelter_compliance_statuses
      list = cfsi_compliant_smelter_list[:hash_data]
      puts list.keys.inspect
      rows =  consolidated_smelters[:data].map do |cs|
                [(list.keys.include?(cs[4]) ? list[cs[4]] : "Not CFSI Compliant"),
                 cs[0], cs[1], cs[2], cs[4]]
              end
      {:name => "Smelter Compliance Statuses",
       :header => [{:name => "Status", :column_width => 20},
                   {:name => "Metal", :column_width => 15},
                   {:name => "Smelter Names", :column_width => 35},
                   {:name => "Smelter Facility Location Country", :column_width => 25},
                   {:name => "Smelter ID", :column_width => 15}],
       :data => rows.sort_by { |row| [['compliant', 'active', 'progressing', 'not cfsi compliant'].index(row[0].downcase) || 4,
                                      mineral_sort_order.index(row[1].downcase) || 5,
                                      row[3],
                                      row[2]]
                              }}
    end

    def smelter_compliance_statuses_worksheet(workbook)
      info  = smelter_compliance_statuses
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Branding header
      worksheet_header(sheet, sheet.styles.add_style(BRANDING_STYLE))
      # Attribute name header
      sheet.add_row(['#'] + info[:header].collect { |h| h[:name] }, :style => sheet.styles.add_style(HEADER_STYLE)).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      column_widths = info[:header].collect { |h| h[:column_width]}
      info[:data].each_with_index do |row, index|
        sheet.add_row([index + 1] + row, :styles => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    def to_excel
      workbook = Axlsx::Workbook.new
      all_reported_smelters_worksheet(workbook)
      consolidated_smelters_worksheet(workbook)
      rejected_entries_worksheet(workbook)
      smelter_compliance_statuses_worksheet(workbook)
      cfsi_compliant_smelter_list_worksheet(workbook)
      workbook.add_worksheet(:name => "Definitions") do |sheet|
        sheet.add_row([self.definition % CHECKMARK_CHAR], :types => :string)
        sheet.merge_cells "A1:H200"
      end
      Axlsx::Package.new :workbook => workbook
    end
  end
end
