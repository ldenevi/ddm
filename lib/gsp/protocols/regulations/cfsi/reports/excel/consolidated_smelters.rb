# encoding: utf-8

module GSP::Protocols::Regulations::CFSI::Reports::Excel
  class ConsolidatedSmelters < Report
    def definition
<<-EOT
INGESTOR REPORT DEFINTIONS
Green Status Pro Ingestor generated the following RCOI reports after processing your
company's supplier's CFSI Conflict Minerals Reporting Templates:

  1. All Reported Smelters Report
  2. Consolidated Smelters Report
  3. Rejected Entries Report
  4. Smelter Compliance Statuses Report
  5. RCOI Analytics Report
  6. Aggregated Declarations Report
  7. Declarations Statistics

These reports are designed to assist you in meeting the SEC-reporting requirements for
Dodd-Frank Section 1502. They do not constitute legal advice.  Users should consult
with their attorneys about their specific situation.


1) ALL REPORTED SMELTERS
The All Reported Smelters Report is the central repository for all your smelter-related
RCOI data. It aggregates all the smelter data provided to you by your suppliers using
any combination of EICC-GeSI CMRT v2 and CFSI CMRT v3 formats.

For each Validation Batch you run or update, this report organizes all smelter entries
exactly as reported by all suppliers. Smelter entries are sorted by Metal, Country,
Standard Smelter Name and Smelter ID. Each smelter entry row includes the supplier’s
additional information regarding the smelter in the same order as listed on the CFSI
Smelter List. Ingestor adds the EICC-GeSI/CFSI CMRT version and the Source File Name.

The All Reported Smelters Report is generated in Excel format to allow you to easily
analyze the data and create custom reports.


2) CONSOLIDATED SMELTER REPORT
The Consolidated Smelter Report lists all the unique smelters that your suppliers have
reasonably reported to be in your company’s supply chain. This report, derived from the
All Reported Smelter Report, provides the smelter identification information you need
in an easy-to-use format.

To maintain the integrity of the Consolidated Smelter Report, each smelter entry must
have valid data in these 5 columns to be included: 1) Metal, 2) Smelter Reference List,
3) Standard Smelter Name, 4) Smelter Country and 4) Smelter ID. Ingestor cross-references
the most recently released CFSI CMRT list of Standard Smelter Names to ensure the validity
of the data. Note that smelter data communicated by suppliers using older CMRT Standard
Smelter Names may be out-of-date and currently incorrect.

To create the Consolidated Smelter Report, Ingestor first eliminates unsupported entries
from the All Reported Smelter Report. Such entries are either missing data, such as a
smelter ID, or have corrupt data, such as a smelter ID in the wrong format. This data
is moved to the Rejected Entries Report. Suppliers whose smelter entries are rejected
should be notified and required to correct the problem.

Ingestor then consolidates duplicate smelter listings. If more than one supplier
identifies the same smelter in its supply chains, Ingestor counts the instances and
references the source files. If an individual supplier reports the use of the same
smelter two or more times on the same CMRT, Ingestor will only count one smelter entry.

The Consolidated Smelter Report’s output is ordered by smelter:
A. Metal
B. Country
C. Standard Smelter Name

This report consolidates smelter listings and eliminates unsupportable entries,
significantly reducing the row count of the All Reported Smelter Report. Therefore, it
will be the basis for generating your own firm’s CMRT that you must provide to your customers.



3) REJECTED ENTRIES
Smelters listed in Rejected Entries Report have missing, inaccurate or ambiguous data
associated with them. The Rejected Entries Report provides a repository of
supplier-smelter entries for which due diligence should be performed to confirm and
improve the accuracy of the reported data. It is critical that you do not pass
incorrect conflict minerals data to your customers.

The Rejected Entries Report consists of smelter entries from the All Reported Smelters
Report that cannot be included in the Consolidated Smelter Report due to missing data,
incorrect data or lack of confidence in the information provided. All supplier-reported
smelters identified in the All Reported Smelters Report will be reported in either the
Consolidated Smelter Report or the Rejected Entries Report.

A smelter entry that does not have valid data in any one of these five categories is
assigned to the Rejected Entries Report:
A. Metal
B. Smelter Reference List
C. Standard Smelter Name
D. Smelter Country
E. Smelter ID

Suppliers whose smelter entries are flagged on the Rejected Entries Report should be
contacted immediately as part of the supplier due diligence process and made aware of
the problem(s) and your company’s policy regarding suppliers who do not maintain an
adequate Conflict Minerals Reporting program.

Rejection Messages are:
Invalid smelter id – ID is either not provided or is in the wrong format.
Invalid smelter name – Smelter name may be missing, not in English, consist of placeholder characters (not words.)
Invalid country – Data in Smelter Facility Location Country field is not that for a country.
Smelter id does not match metal – Smelter ID Version 2 has a country code embedded in it. Ingestor checks that the country code and V2 id are consistent. If not, this message appears.
Invalid country code for v2 smelter id – Supplier entry contains an invalid country code within the ID Version 2 Smelter code.


The Rejected Entries Report provides companies with a solid foundation for evaluating
the risks inherent in their 3TG supply chains.


4) SMELTER COMPLIANCE STATUSES REPORT
Identifies which smelters listed in the Consolidated Smelter Report have been designated
as Compliant, Active, or Progressing in the CFSI Conflict-free Smelter Program. Matches
the smelter IDs reported in the Consolidated Smelter report against the current
CFSI-published listing of smelters that have passed or are actively participating in its
conflict-free audit requirements program.

Smelters that do not have smelter ID matches with the CFSI listing are categorized as
Not CFSI Compliant.



5) RCOI ANALYTICS


6) AGGREGATED DECLARATIONS REPORT

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
        sheet.add_row([index + 1] + row, :style => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    #
    # Consolidated Smelters worksheet
    def consolidated_smelters
      @consolidated_smelters ||= begin
        @rejected_entries = []
        @clean_entries = []

        puts "Splitting clean and dirty entries..."
        self.sorted_smelters.each do |data|
          smelter = data[:smelter]
          rejection_reasons = []
          rejection_reasons << "Invalid smelter id" unless smelter.has_valid_smelter_id?
          rejection_reasons << "Invalid country code for v2 smelter id" if smelter.has_valid_v2_smelter_id? && !smelter.is_v2_smelter_id_country_code_valid?
          rejection_reasons << "Invalid smelter name" unless smelter.has_valid_smelter_name?
          rejection_reasons << "Invalid country" unless Rails.configuration.cfsi.countries.map { |c| c.gsub(/\W/,'') }.include?(smelter.facility_location_country.gsub(/\W/,'').upcase)
          rejection_reasons << "Invalid metal" unless smelter.has_valid_mineral?
          rejection_reasons << "Smelter id does not match metal" if smelter.has_valid_smelter_id? && !smelter.does_mineral_match_v2_smelter_id?
          if rejection_reasons.empty?
            putc '+'
            @clean_entries << data
          else
            putc '-'
            @rejected_entries << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name,
                                  smelter.facility_location_country, smelter.v2_smelter_id, smelter.v3_smelter_id,
                                  rejection_reasons.join(', '), data[:filename],
                                  data[:declaration].company_name, data[:declaration].authorized_company_representative_name, data[:declaration].contact_email, data[:declaration].contact_phone]
          end
        end

        grouped_smelters = {}
        # Load GSP-corrected standard smelter name
        threads = []
        @clean_entries.in_groups(2, false).each do |grouped|
          threads << Thread.new do
            grouped.each do |data|
              putc '*'
              data[:smelter].gsp_standard_name
            end
          end
        end
        threads.each { |t| t.join }

        # TODO This is the second time the database is being queried for the SmelterReference list. Reduce this to only one.
        gsp_smelter_reference_list = Cfsi::Reports::SmelterReference.all
        @referenced_clean_entries = []
        @clean_entries.each do |data|
          putc '^'
          smelter = data[:smelter]
          rejection_reasons = []
          referenced_smelters = gsp_smelter_reference_list.select { |e| e.standard_name == smelter.gsp_standard_name }
          if referenced_smelters.empty?
            rejection_reasons << "Smelter name not found in Smelter Reference List"
          else
            smelter.facility_location_country = "RUSSIAN FEDERATION" if smelter.facility_location_country.downcase =~ /russia/

            rejection_reasons << "Country does not match Smelter Reference List for smelter name" unless referenced_smelters.map { |rs| rs.country.gsub(/\W/,'').downcase }.include?(smelter.facility_location_country.gsub(/\W/,'').downcase)
            rejection_reasons << "Smelter ID does not match Smelter Reference List for smelter name" unless (smelter.v2_smelter_id && referenced_smelters.map { |rs| rs.v2_smelter_id.to_s.downcase }.include?(smelter.v2_smelter_id.downcase)) ||
                                                                                                             (smelter.v3_smelter_id && referenced_smelters.map { |rs| rs.v3_smelter_id.to_s.downcase }.include?(smelter.v3_smelter_id.downcase))
          end

          if rejection_reasons.empty?
            @referenced_clean_entries << data
          else
            @rejected_entries << [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name,
                                  smelter.facility_location_country, smelter.v2_smelter_id, smelter.v3_smelter_id,
                                  rejection_reasons.join(', '), data[:filename],
                                  data[:declaration].company_name, data[:declaration].authorized_company_representative_name, data[:declaration].contact_email, data[:declaration].contact_phone]
          end
        end

        @referenced_clean_entries.each do |data|
          putc '.'
          smelter = data[:smelter]
          smelter_key = smelter.vendor_key
          row = [smelter.metal, smelter.gsp_standard_name, smelter.facility_location_country, smelter.v2_smelter_id, smelter.v3_smelter_id].map(&:to_s)
          grouped_smelters[smelter_key] = {:group_row => [], :individual_entries => [], :declaration_filenames => [], :reported_countries => []} if grouped_smelters[smelter_key].nil?
          grouped_smelters[smelter_key][:individual_entries] << row + [data[:file_name]]
          grouped_smelters[smelter_key][:declaration_filenames] << data[:file_name]
          grouped_smelters[smelter_key][:reported_countries] << smelter.facility_location_country
        end
        grouped_smelters.each do |vendor_key, data|
          putc '-'
          country = begin
            country_tally = {}
            reported_countries = data[:reported_countries].map(&:downcase)
            reported_countries.uniq.each do |country|
              country_tally.merge!({reported_countries.count(country) => country.upcase})
            end
            country_tally[country_tally.keys.max]
          end
          an_entry = data[:individual_entries].first
          source_cmrts = data[:declaration_filenames].uniq.sort
          data[:group_row] = [an_entry[0], an_entry[1], country, an_entry[3], an_entry[4], source_cmrts.size, source_cmrts.join(', ')]
        end

        rows = []
        grouped_smelters.each { |key, val| rows << {:row => val[:group_row]} }
        putc '|'
        {:name => "Consolidated Smelters",
         :header => [{:name => "Metal", :column_width => 15},
                     {:name => "Standard Smelter Names", :column_width => 35},
                     {:name => "Smelter Facility Location Country", :column_width => 35},
                     {:name => "Smelter ID\nVersion 2", :column_width => 15},
                     {:name => "Smelter ID\nVersion 3", :column_width => 15},
                     {:name => "Number of\nSource CFSI\nCM Report Files", :column_width => 20},
                     {:name => "Source Files", :column_width => 60}],
          :data => rows.sort_by { |r| [r[:row][0].downcase, r[:row][2].downcase, r[:row][1].downcase] }}
      end
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
        sheet_row = sheet.add_row([index + 1] + row[:row], :style => data_style, :types => :string, :widths => [6] + column_widths)
        # smelter_name_cell = sheet_row.cells[2]
        # sheet.add_comment(:author => "Consolidated From:\n", :text => row[:source_names], :ref => smelter_name_cell)
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
                   {:name => "Smelter ID\nVersion 2", :column_width => 25},
                   {:name => "Smelter ID\nVersion 3", :column_width => 25},
                   {:name => "Rejection Reason(s)", :column_width => 35},
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
        sheet.add_row([index + 1] + row, :style => data_style, :types => :string, :widths => [6] + column_widths)
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
        sheet.add_row([index + 1] + row, :style => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    #
    # Smelter Compliance Statuses
    def smelter_compliance_statuses
      list = cfsi_compliant_smelter_list[:hash_data]
      rows =  consolidated_smelters[:data].map do |cs|
                cs = cs[:row]
                [(list.keys.include?(cs[4]) ? list[cs[4]] : "Not CFSI Compliant"),
                 cs[0], cs[1], cs[2], cs[4]].map(&:to_s)
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
        sheet.add_row([index + 1] + row, :style => data_style, :types => :string, :widths => [6] + column_widths)
      end
      sheet
    end

    def analytics
      csmelters = consolidated_smelters[:data].map { |d| d[:row] }
      compl_statuses = smelter_compliance_statuses[:data]
      num_cfsi_compliant_smelters = compl_statuses.select { |s| s[0] != "Not CFSI Compliant" }.size
      num_cfsi_compliant_gold_smelters     = compl_statuses.select { |s| s[0] != "Not CFSI Compliant" && s[1].downcase == 'gold' }.size
      num_cfsi_compliant_tin_smelters      = compl_statuses.select { |s| s[0] != "Not CFSI Compliant" && s[1].downcase == 'tin' }.size
      num_cfsi_compliant_tantalum_smelters = compl_statuses.select { |s| s[0] != "Not CFSI Compliant" && s[1].downcase == 'tantalum' }.size
      num_cfsi_compliant_tungsten_smelters = compl_statuses.select { |s| s[0] != "Not CFSI Compliant" && s[1].downcase == 'tungsten' }.size
      num_not_cfsi_compliant_smelters          = compl_statuses.size - num_cfsi_compliant_smelters
      num_not_cfsi_compliant_gold_smelters     = compl_statuses.select { |s| s[0] == "Not CFSI Compliant" && s[1].downcase == 'gold' }.size
      num_not_cfsi_compliant_tin_smelters      = compl_statuses.select { |s| s[0] == "Not CFSI Compliant" && s[1].downcase == 'tin' }.size
      num_not_cfsi_compliant_tantalum_smelters = compl_statuses.select { |s| s[0] == "Not CFSI Compliant" && s[1].downcase == 'tantalum' }.size
      num_not_cfsi_compliant_tungsten_smelters = compl_statuses.select { |s| s[0] == "Not CFSI Compliant" && s[1].downcase == 'tungsten' }.size
      gold_countries     = csmelters.select { |s| s[0].downcase == 'gold' }.collect { |s| s[2] }.sort.uniq
      tin_countries      = csmelters.select { |s| s[0].downcase == 'tin' }.collect { |s| s[2] }.sort.uniq
      tantalum_countries = csmelters.select { |s| s[0].downcase == 'tantalum' }.collect { |s| s[2] }.sort.uniq
      tungsten_countries = csmelters.select { |s| s[0].downcase == 'tungsten' }.collect { |s| s[2] }.sort.uniq

      {:name => "Analytics",
       :rows => [
                 ["Number of suppliers reporting:", validations_batch.latest_cmrt_validations.size],
                 [""],
                 ["Number of individual smelters reported:", csmelters.size],
                 ["GOLD:", csmelters.select { |s| s[0].downcase == 'gold' }.size],
                 ["TIN:", csmelters.select { |s| s[0].downcase == 'tin' }.size],
                 ["TANTALUM:", csmelters.select { |s| s[0].downcase == 'tantalum' }.size],
                 ["TUNGSTEN:", csmelters.select { |s| s[0].downcase == 'tungsten' }.size],
                 [""],
                 ["Smelters listed as CFSI Compliant:", num_cfsi_compliant_smelters, "%.2f%%" % ((num_cfsi_compliant_smelters.to_f / csmelters.size.to_f) * 100)],
                 ["GOLD:", num_cfsi_compliant_gold_smelters, "%.2f%%" % ((num_cfsi_compliant_gold_smelters.to_f / num_cfsi_compliant_smelters.to_f) * 100)],
                 ["TIN:", num_cfsi_compliant_tin_smelters, "%.2f%%" % ((num_cfsi_compliant_tin_smelters.to_f / num_cfsi_compliant_smelters.to_f) * 100)],
                 ["TANTALUM:", num_cfsi_compliant_tantalum_smelters, "%.2f%%" % ((num_cfsi_compliant_tantalum_smelters.to_f / num_cfsi_compliant_smelters.to_f) * 100)],
                 ["TUNGSTEN:", num_cfsi_compliant_tungsten_smelters, "%.2f%%" % ((num_cfsi_compliant_tungsten_smelters.to_f / num_cfsi_compliant_smelters.to_f) * 100)],
                 [""],
                 ["Smelters listed as Not CFSI Compliant:", num_not_cfsi_compliant_smelters, "%.2f%%" % ((num_not_cfsi_compliant_smelters.to_f / csmelters.size.to_f) * 100)],
                 ["GOLD:", num_not_cfsi_compliant_gold_smelters, "%.2f%%" % ((num_not_cfsi_compliant_gold_smelters.to_f / num_not_cfsi_compliant_smelters.to_f) * 100)],
                 ["TIN:", num_not_cfsi_compliant_tin_smelters, "%.2f%%" % ((num_not_cfsi_compliant_tin_smelters.to_f / num_not_cfsi_compliant_smelters.to_f) * 100)],
                 ["TANTALUM:", num_not_cfsi_compliant_tantalum_smelters, "%.2f%%" % ((num_not_cfsi_compliant_tantalum_smelters.to_f / num_not_cfsi_compliant_smelters.to_f) * 100)],
                 ["TUNGSTEN:", num_not_cfsi_compliant_tungsten_smelters, "%.2f%%" % ((num_not_cfsi_compliant_tungsten_smelters.to_f / num_not_cfsi_compliant_smelters.to_f) * 100)],
                 [""],
                 ["Number of countries of origin:", csmelters.map { |s| s[2].downcase }.compact.uniq.size],
                 ["Countries of origin:", csmelters.collect { |s| s[2] }.compact.sort.uniq.join('; ')],
                 ["GOLD"],
                 ["Count:", gold_countries.size],
                 ["Countries:", gold_countries.join('; ')],
                 ["TIN"],
                 ["Count:", tin_countries.size],
                 ["Countries:", tin_countries.join('; ')],
                 ["TANTALUM"],
                 ["Count:", tantalum_countries.size],
                 ["Countries:", tantalum_countries.join('; ')],
                 ["TUNGSTEN"],
                 ["Count:", tungsten_countries.size],
                 ["Countries:", tungsten_countries.join('; ')]
                ]

      }
    end

    def analytics_worksheet(workbook)
      info  = analytics
      sheet = Axlsx::Worksheet.new workbook, :name => info[:name]
      # Attribute name header
      sheet.add_row(["","",""]).height = 35.0
      # Data rows
      data_style    = sheet.styles.add_style DATA_STYLE
      info[:rows].each do |row|
        sheet.add_row(row, :widths => [45, 15, 200], :style => data_style, :types => :string)
      end
      sheet.merge_cells "B23:C23"
      sheet.merge_cells "B26:C26"
      sheet.merge_cells "B29:C29"
      sheet.merge_cells "B32:C32"
      sheet.merge_cells "B25:C25"
      sheet
    end

    def to_excel
      workbook = Axlsx::Workbook.new
      all_reported_smelters_worksheet(workbook)
      consolidated_smelters_worksheet(workbook)
      rejected_entries_worksheet(workbook)
      smelter_compliance_statuses_worksheet(workbook)
      cfsi_compliant_smelter_list_worksheet(workbook)
      analytics_worksheet(workbook)
      workbook.add_worksheet(:name => "Definitions") do |sheet|
        style = sheet.styles.add_style(BRANDING_STYLE)
        sheet.merge_cells "A1:H200"
        sheet.add_row([self.definition % CHECKMARK_CHAR], :types => :string, :style => style)
      end
      Axlsx::Package.new :workbook => workbook
    end
  end
end
