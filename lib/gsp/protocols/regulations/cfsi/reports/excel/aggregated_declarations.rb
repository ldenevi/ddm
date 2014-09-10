module GSP::Protocols::Regulations::CFSI::Reports::Excel
  class AggregatedDeclarations < Report


    def aggregated_declarations
      {:name => "Aggregated Declarations",
       :header => [{:name => "Company Name", :column_width => 20},
                   {:name => "Declaration Scope", :column_width => 35},
                   {:name => "Description of Scope", :column_width => 35, :question => ""},
                   {:name => "Company Unique Identifier", :column_width => 20, :question => ""},
                   {:name => "Company Unique ID Authority", :column_width => 25, :question => ""},
                   {:name => "Address", :column_width => 25, :question => ""},
                   {:name => "Contact Name", :column_width => 25, :question => ""},
                   {:name => "Email-Contact", :column_width => 25, :question => ""},
                   {:name => "Phone-Contact", :column_width => 30, :question => ""},
                   {:name => "Authorizer", :column_width => 20, :question => ""},
                   {:name => "Title - Authorizer", :column_width => 15, :question => ""},
                   {:name => "Email - Authorizer", :column_width => 40, :question => ""},
                   {:name => "Phone - Authorizer", :column_width => 30, :question => ""},
                   {:name => "Effective Date", :column_width => 40, :question => ""},

                   # Minerals Questions
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q1-v3: Is the conflict metal intentionally added to your product?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q1 - v2: Are any of the following metals necessary to the functionality or production of your company's products that it manufacturers or contracts to manufacture?\n\n Q2-v3: Is the conflict metal necessary to the production of your company's product and contained in the finished product that your company manufactures or contracts to manufacture?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q2 - v2: Do the following metals (necessary to the functionality or production of your company's products) originate from the DRC or an adjoining country?\n\nQ3 -v3: Does any of the conflict metal originate from the covered countries?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q3 - v2: Do the following metals (necessary to the functionality or production of your company's products) come from a recycler or scrap supplier? \n\nQ4 - v3: Does 100 percent of the conflict metal (necessary to the functionality or production of your products) originate from recycled or scrap sources?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q4 - v2: Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?\n\nQ5 - v3: Have you received conflict metals data/information for each metal from all relevant suppliers of 3TG?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q5 - v2: For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope?\n\nQ6 - v3: For each conflict mineral, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q6 - v2: Have all of the smelters used by your company and its suppliers been validated as compliant in accordance with the Conflict-Free Smelter (CFS) Program and listed on the Compliant Smelter List for the following metals?\n\nQ7 - v3: Has all applicable smelter information received by your company been reported in this declaration?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},

                   # Company level questions
                   {:name => "Question A", :column_width => 15, :question => "QA - V2&3: Do you have a policy in place that includes DRC conflict-free sourcing?"},
                   {:name => "Question A Comments", :column_width => 40, :question => ""},
                   {:name => "Question B", :column_width => 15, :question => "QB -v2: Is this policy publicly available on your website?\n\nQB - v3: Is your conflict minerals sourcing policy publicly available on your website? (Note: If yes, the user shall specify the URL in the comment field.)"},
                   {:name => "Question B Comments", :column_width => 40, :question => ""},
                   {:name => "Question C", :column_width => 15, :question => "QC - V2&3: Do you require your direct suppliers to be DRC Conflict Free?"},
                   {:name => "Question C Comments", :column_width => 40, :question => ""},
                   {:name => "Question D", :column_width => 15, :question => "QD - v2: Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?\n\nQD - v3: Do you require your direct suppliers to source from smelters validated by an independent private sector audit firm?"},
                   {:name => "Question D Comments", :column_width => 40, :question => ""},
                   {:name => "Question E", :column_width => 15, :question => "QE - V2&3: Have you implemented due diligence measures for conflict-free sourcing?"},
                   {:name => "Question E Comments", :column_width => 40, :question => ""},
                   {:name => "Question F", :column_width => 15, :question => "QF -V2 Do you request your suppliers to fill out this Conflict Minerals Reporting Template?\n\nQF - v3: Do you collect conflict minerals due diligence information from your suppliers which is in conformance with the IPC-1755 Conflict Minerals Data Exchange standard [e.g. CFSI Conflict Minerals Reporting Template]?"},
                   {:name => "Question F Comments", :column_width => 40, :question => ""},
                   {:name => "Question G", :column_width => 15, :question => "QG - V2&3: Do you request smelter names from your suppliers?"},
                   {:name => "Question G Comments", :column_width => 40, :question => ""},
                   {:name => "Question H", :column_width => 15, :question => "QH - v2: Do you verify due diligence information received from your suppliers?\n\nQH - v3: Do you review due diligence information received from your suppliers against your company's expectations?"},
                   {:name => "Question H Comments", :column_width => 40, :question => ""},
                   {:name => "Question I", :column_width => 15, :question => "QI - v2: Does your verification process include corrective action management?\n\nQI - v3: Does your review process include corrective action management?"},
                   {:name => "Question I Comments", :column_width => 40, :question => ""},
                   {:name => "Question J", :column_width => 15, :question => "QJ - v2: Are you subject to the SEC Conflict Minerals disclosure requirement rule?\n\nQJ - v3: Are you subject to the SEC Conflict Minerals rule?"},
                   {:name => "Question J Comments", :column_width => 40, :question => ""},

                   # Misc
                   {:name => "Uploaded At", :column_width => 20},
                   {:name => "CMRT File Name", :column_width => 20},
                   {:name => "CFSI Template Version", :column_width => 20},
                   {:name => "Status", :column_width => 20},
                   {:name => "Issues", :column_width => 200}],
       :data => validations_batch.latest_cmrt_validations.collect do |val|
                  next unless val.has_declaration?
                  dec = val.cmrt.declaration
                  date = dec.completion_at || dec.effective_date
                  row = [dec.company_name,
                         dec.declaration_scope,
                         dec.description_of_scope,
                         dec.company_unique_identifier,
                         dec.company_unique_id_authority,
                         dec.address,
                         dec.authorized_company_representative_name,
                         dec.contact_email,
                         dec.contact_phone,
                         dec.authorizer,
                         dec.authorizer_title || dec.contact_title,
                         dec.authorizer_email,
                         dec.authorizer_phone,
                         date.nil? ? "" : date.strftime('%B %d, %Y')]
                  dec.minerals_questions.sort_by(&:sequence).each_with_index do |mq, index|
                    if dec.version.match(/^2/) && [0, 6].include?(index)
                      row += [""] * 8
                    end
                    row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]
                  end
                  dec.company_level_questions.sort_by(&:sequence).each do |clq|
                    row += [clq.answer, clq.comment]
                  end
                  row += [dec.created_at.to_formatted_s(:local), val.file_name,  dec.version, val.status, val.issues.to_s.gsub(/(<li>|<\/li>)/, "; ")]
                end.compact
      }
    end

    def aggregated_declarations_worksheet(workbook)
      sheet = Axlsx::Worksheet.new workbook, :name => "Aggregated Declarations"
      info = aggregated_declarations

      @questions = info[:header].collect { |h| h[:question] }.compact
      branding_style = sheet.styles.add_style(:sz => 9, :font_name => "Lucida Console", :alignment => {:horizontal => :left, :vertical => :top, :wrap_text => true})
      worksheet_header(sheet, branding_style)

      header_style = sheet.styles.add_style(:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true})
      data_style   = sheet.styles.add_style(:sz => 9, :alignment => {:horizontal => :left, :vertical => :top , :wrap_text => true})


      sheet.add_row(["#"] + info[:header].collect { |h| h[:name] }, :style => header_style).height = 35.0
      friendly_index = 1
      info[:data].each do |row|
        sheet.add_row([friendly_index] + row, :style => data_style, :types => :string, :widths => [6] + info[:header].collect { |h| h[:column_width]})
        friendly_index += 1
      end
      sheet
    end

    def worksheet_header(worksheet, style)
      worksheet.add_image(:image_src => LOGO_IMAGE_PATH, :noSelect => true, :noMove => true) do |image|
       image.width  = 4
       image.height = 3
       image.start_at 0, 0
       image.end_at 2, 1
      end

      worksheet.merge_cells "A1:B1"
      worksheet.merge_cells "C1:O1"
      # Questions
      worksheet.merge_cells "P1:W1"
      worksheet.merge_cells "X1:AE1"
      worksheet.merge_cells "AF1:AM1"
      worksheet.merge_cells "AN1:AU1"
      worksheet.merge_cells "AV1:BC1"
      worksheet.merge_cells "BD1:BK1"
      worksheet.merge_cells "BL1:BS1"

      worksheet.merge_cells "BT1:BU1"
      worksheet.merge_cells "BV1:BW1"
      worksheet.merge_cells "BX1:BY1"
      worksheet.merge_cells "BZ1:CA1"
      worksheet.merge_cells "CB1:CC1"
      worksheet.merge_cells "CD1:CE1"
      worksheet.merge_cells "CF1:CG1"

      worksheet.add_row(["", "",[worksheet.name,
                                "%s: %s" % ["Co.".rjust(6, ' '), validations_batch.organization.name],
                                "%s: %s" % ["Date".rjust(6, ' '), Date.today],
                                "%s: %s" % ["Time".rjust(6, ' '), Time.now.strftime("%H:%M:%S")],
                                "%s: %s" % ["User".rjust(6, ' '), validations_batch.user.eponym]
                                ].join("\n")] + @questions, :style => style).height = 65.0

      # Freeze pane over data rows
      worksheet.sheet_view.pane do |pane|
        pane.top_left_cell = "A3"
        pane.state = :frozen_split
        pane.y_split = 2
        pane.x_split = 0
        pane.active_pane = :bottom_right
      end
    end

    def statistics
      total = validations_batch.latest_cmrt_validations.collect { |val| next unless val.has_declaration?; val.cmrt.declaration }.compact.size
      stats = {
      :number_of_companies => total,

      :answered_yes_for_any_metal => 0,
      :answered_yes_for_tantalum  => 0,
      :answered_yes_for_tin       => 0,
      :answered_yes_for_gold      => 0,
      :answered_yes_for_tungsten  => 0,

      :reported_cm_tantalum => 0,
      :reported_cm_tin      => 0,
      :reported_cm_gold     => 0,
      :reported_cm_tungsten => 0,

      :number_of_cm_none  => 0,
      :number_of_cm_one   => 0,
      :number_of_cm_two   => 0,
      :number_of_cm_three => 0,
      :number_of_cm_four  => 0,

      :reported_all_tantalum_identified => 0,
      :reported_all_tin_identified      => 0,
      :reported_all_gold_identified     => 0,
      :reported_all_tungsten_identified => 0,

      :supplier_response_100_tantalum => 0,
      :supplier_response_100_tin      => 0,
      :supplier_response_100_gold     => 0,
      :supplier_response_100_tungsten => 0,
      :supplier_response_75_tantalum => 0,
      :supplier_response_75_tin      => 0,
      :supplier_response_75_gold     => 0,
      :supplier_response_75_tungsten => 0,
      :supplier_response_50_tantalum => 0,
      :supplier_response_50_tin      => 0,
      :supplier_response_50_gold     => 0,
      :supplier_response_50_tungsten => 0,
      :supplier_response_25_tantalum => 0,
      :supplier_response_25_tin      => 0,
      :supplier_response_25_gold     => 0,
      :supplier_response_25_tungsten => 0,
      :supplier_response_1_tantalum => 0,
      :supplier_response_1_tin      => 0,
      :supplier_response_1_gold     => 0,
      :supplier_response_1_tungsten => 0,
      :supplier_response_0_tantalum => 0,
      :supplier_response_0_tin      => 0,
      :supplier_response_0_gold     => 0,
      :supplier_response_0_tungsten => 0,

      :reported_policy_in_place   => 0,

      :reported_policy_on_website => 0,

      :reported_subject_to_sec => 0,

      :status_green             => 0,
      :status_validation_needed => 0,
      :status_high_risk         => 0,

      :scoped_at_company_level => 0,
      :scoped_at_product_level => 0,
      :scoped_at_other         => 0}

      validations_batch.latest_cmrt_validations.each do |val|
        next unless val.has_declaration?

        dec  = val.cmrt.declaration
        mqs  = dec.minerals_questions.sort_by(&:sequence)
        clqs = dec.company_level_questions.sort_by(&:sequence)
        is_version_2 = dec.version =~ /^2/

        has_tantalum = is_version_2 ? (mqs[1].tantalum.to_s.downcase == 'yes') : ([mqs[0].tantalum.to_s.downcase, mqs[1].tantalum.to_s.downcase].include?('yes'))
        has_tin      = is_version_2 ? (mqs[1].tin.to_s.downcase == 'yes') : ([mqs[0].tin.to_s.downcase, mqs[1].tin.to_s.downcase].include?('yes'))
        has_gold     = is_version_2 ? (mqs[1].gold.to_s.downcase == 'yes') : ([mqs[0].gold.to_s.downcase, mqs[1].gold.to_s.downcase].include?('yes'))
        has_tungsten = is_version_2 ? (mqs[1].tungsten.to_s.downcase == 'yes') : ([mqs[0].tungsten.to_s.downcase, mqs[1].tungsten.to_s.downcase].include?('yes'))

        stats[:answered_yes_for_any_metal] += 1 if has_tantalum || has_tin || has_gold || has_tungsten
        stats[:answered_yes_for_tantalum]  += 1 if has_tantalum
        stats[:answered_yes_for_tin]       += 1 if has_tin
        stats[:answered_yes_for_gold]      += 1 if has_gold
        stats[:answered_yes_for_tungsten]  += 1 if has_tungsten

        has_cm_tantalum = is_version_2 ? mqs[1].tantalum.to_s.downcase == 'yes' : mqs[2].tantalum.to_s.downcase == 'yes'
        has_cm_tin      = is_version_2 ? mqs[1].tin.to_s.downcase == 'yes' : mqs[2].tin.to_s.downcase == 'yes'
        has_cm_gold     = is_version_2 ? mqs[1].gold.to_s.downcase == 'yes' : mqs[2].gold.to_s.downcase == 'yes'
        has_cm_tungsten = is_version_2 ? mqs[1].tungsten.to_s.downcase == 'yes' : mqs[2].tungsten.to_s.downcase == 'yes'

        stats[:reported_cm_tantalum] += 1 if has_cm_tantalum
        stats[:reported_cm_tin]      += 1 if has_cm_tin
        stats[:reported_cm_gold]     += 1 if has_cm_gold
        stats[:reported_cm_tungsten] += 1 if has_cm_tungsten

        stats[:number_of_cm_none]  += 1 if ([has_cm_tantalum, has_cm_tin, has_cm_gold, has_cm_tungsten] - [false]).size == 0
        stats[:number_of_cm_one]   += 1 if ([has_cm_tantalum, has_cm_tin, has_cm_gold, has_cm_tungsten] - [false]).size == 1
        stats[:number_of_cm_two]   += 1 if ([has_cm_tantalum, has_cm_tin, has_cm_gold, has_cm_tungsten] - [false]).size == 2
        stats[:number_of_cm_three] += 1 if ([has_cm_tantalum, has_cm_tin, has_cm_gold, has_cm_tungsten] - [false]).size == 3
        stats[:number_of_cm_four]  += 1 if ([has_cm_tantalum, has_cm_tin, has_cm_gold, has_cm_tungsten] - [false]).size == 4

        stats[:reported_all_tantalum_identified] += 1 if is_version_2 ? mqs[4].tantalum.to_s.downcase =~ /^yes/ : mqs[5].tantalum.to_s.downcase == 'yes'
        stats[:reported_all_tin_identified]      += 1 if is_version_2 ? mqs[4].tin.to_s.downcase =~ /^yes/ : mqs[5].tin.to_s.downcase == 'yes'
        stats[:reported_all_gold_identified]     += 1 if is_version_2 ? mqs[4].gold.to_s.downcase =~ /^yes/ : mqs[5].gold.to_s.downcase == 'yes'
        stats[:reported_all_tungsten_identified] += 1 if is_version_2 ? mqs[4].tungsten.to_s.downcase =~ /^yes/ : mqs[5].tungsten.to_s.downcase == 'yes'

        stats[:supplier_response_100_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /^yes/ : mqs[4].tantalum.to_s.downcase =~ /^yes/
        stats[:supplier_response_100_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /^yes/ : mqs[4].tin.to_s.downcase =~ /^yes/
        stats[:supplier_response_100_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /^yes/ : mqs[4].gold.to_s.downcase =~ /^yes/
        stats[:supplier_response_100_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /^yes/ : mqs[4].tungsten.to_s.downcase =~ /^yes/
        stats[:supplier_response_75_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /75/ : mqs[4].tantalum.to_s.downcase =~ /75/
        stats[:supplier_response_75_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /75/ : mqs[4].tin.to_s.downcase =~ /75/
        stats[:supplier_response_75_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /75/ : mqs[4].gold.to_s.downcase =~ /75/
        stats[:supplier_response_75_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /75/ : mqs[4].tungsten.to_s.downcase =~ /75/
        stats[:supplier_response_50_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /50/ : mqs[4].tantalum.to_s.downcase =~ /50/
        stats[:supplier_response_50_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /50/ : mqs[4].tin.to_s.downcase =~ /50/
        stats[:supplier_response_50_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /50/ : mqs[4].gold.to_s.downcase =~ /50/
        stats[:supplier_response_50_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /50/ : mqs[4].tungsten.to_s.downcase =~ /50/
        stats[:supplier_response_25_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /> 25/ : mqs[4].tantalum.to_s.downcase =~ /greater than 25/
        stats[:supplier_response_25_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /> 25/ : mqs[4].tin.to_s.downcase =~ /greater than 25/
        stats[:supplier_response_25_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /> 25/ : mqs[4].gold.to_s.downcase =~ /greater than 25/
        stats[:supplier_response_25_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /> 25/ : mqs[4].tungsten.to_s.downcase =~ /greater than 25/
        stats[:supplier_response_1_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /< 25/ : mqs[4].tantalum.to_s.downcase =~ /less than 25/
        stats[:supplier_response_1_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /< 25/ : mqs[4].tin.to_s.downcase =~ /less than 25/
        stats[:supplier_response_1_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /< 25/ : mqs[4].gold.to_s.downcase =~ /less than 25/
        stats[:supplier_response_1_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /< 25/ : mqs[4].tungsten.to_s.downcase =~ /less than 25/
        stats[:supplier_response_0_tantalum] += 1 if is_version_2 ? mqs[3].tantalum.to_s.downcase =~ /none/ : mqs[4].tantalum.to_s.downcase =~ /none/
        stats[:supplier_response_0_tin]      += 1 if is_version_2 ? mqs[3].tin.to_s.downcase =~ /none/ : mqs[4].tin.to_s.downcase =~ /none/
        stats[:supplier_response_0_gold]     += 1 if is_version_2 ? mqs[3].gold.to_s.downcase =~ /none/ : mqs[4].gold.to_s.downcase =~ /none/
        stats[:supplier_response_0_tungsten] += 1 if is_version_2 ? mqs[3].tungsten.to_s.downcase =~ /none/ : mqs[4].tungsten.to_s.downcase =~ /none/

        stats[:reported_policy_in_place] += 1 if clqs[0].answer.to_s.downcase == 'yes'

        stats[:reported_policy_on_website] += 1 if clqs[1].answer.to_s.downcase == 'yes'

        stats[:reported_subject_to_sec] += 1 if clqs.last.answer.to_s.downcase == 'yes'

        stats[:status_green]             += 1 if val.status == 'Green'
        stats[:status_validation_needed] += 1 if val.status.to_s.downcase == 'validation needed'
        stats[:status_high_risk]         += 1 if val.status.to_s.downcase == 'high risk'

        stats[:scoped_at_company_level] += 1 if dec.declaration_scope.to_s.downcase =~ /company/
        stats[:scoped_at_product_level] += 1 if dec.declaration_scope.to_s.downcase =~ /product/
        stats[:scoped_at_other]         += 1 unless dec.declaration_scope.to_s.downcase =~ /company/ || dec.declaration_scope.to_s.downcase =~ /product/
      end
      stats
    end

    def statistics_worksheet(workbook)
      stats = statistics
      sheet = Axlsx::Worksheet.new workbook, :name => "Declarations Statistics"
      sheet.add_row(["","",""])

      # Styles
      h2 = sheet.styles.add_style :b => true, :sz => 10, :alignment => {:horizontal => :right, :vertical => :center, :wrap_text => true}
      right_align = sheet.styles.add_style :alignment => {:horizontal => :right}
      center_align = sheet.styles.add_style :alignment => {:horizontal => :center}

      sheet.add_row ["Number of Companies", stats[:number_of_companies], "100%"], :style => [h2, nil, nil]

      unless stats[:number_of_companies] == 0

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting Conflict Minerals", "", ""], :style => h2
        sheet.add_row ["Tantalum", stats[:reported_cm_tantalum], ("%.2f%%" % (stats[:reported_cm_tantalum] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tin", stats[:reported_cm_tin], ("%.2f%%" % (stats[:reported_cm_tin] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Gold", stats[:reported_cm_gold], ("%.2f%%" % (stats[:reported_cm_gold] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tungsten", stats[:reported_cm_tungsten], ("%.2f%%" % (stats[:reported_cm_tungsten] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting Conflict Minerals Originating from the DRC or adjoining countries", "", ""], :style => h2
        sheet.add_row ["Answered \"Yes\" for any metal", stats[:answered_yes_for_any_metal], ("%.2f%%" % (stats[:answered_yes_for_any_metal].to_f / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tantalum", stats[:answered_yes_for_tantalum], ("%.2f%%" % (stats[:answered_yes_for_tantalum].to_f / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tin", stats[:answered_yes_for_tin], ("%.2f%%" % (stats[:answered_yes_for_tin].to_f / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Gold", stats[:answered_yes_for_gold], ("%.2f%%" % (stats[:answered_yes_for_gold] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tungsten", stats[:answered_yes_for_tungsten], ("%.2f%%" % (stats[:answered_yes_for_tungsten] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting Number of Conflict Minerals", "", ""], :style => h2
        sheet.add_row ["None", stats[:number_of_cm_none], ("%.2f%%" % (stats[:reported_cm_tantalum] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["1", stats[:number_of_cm_one], ("%.2f%%" % (stats[:number_of_cm_one] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["2", stats[:number_of_cm_two], ("%.2f%%" % (stats[:number_of_cm_two] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["3", stats[:number_of_cm_three], ("%.2f%%" % (stats[:number_of_cm_three] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["4", stats[:number_of_cm_four], ("%.2f%%" % (stats[:number_of_cm_four] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting All Smelters Were Identified", "", ""], :style => h2
        sheet.add_row ["Tantalum", stats[:reported_all_tantalum_identified], ("%.2f%%" % (stats[:reported_all_tantalum_identified] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tin", stats[:reported_all_tin_identified], ("%.2f%%" % (stats[:reported_all_tin_identified] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Gold", stats[:reported_all_gold_identified], ("%.2f%%" % (stats[:reported_all_gold_identified] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tungsten", stats[:reported_all_tungsten_identified], ("%.2f%%" % (stats[:reported_all_tungsten_identified] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Company Reports Regarding Supplier Responses", "100%", "75% - 99%", "50% - 74%", "25% - 49%", "1% - 24%", "None - 0%"], :style => h2
        sheet.add_row ["Tantalum", stats[:supplier_response_100_tantalum], stats[:supplier_response_75_tantalum], stats[:supplier_response_50_tantalum], stats[:supplier_response_25_tantalum], stats[:supplier_response_1_tantalum], stats[:supplier_response_0_tantalum]], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tin", stats[:supplier_response_100_tin], stats[:supplier_response_75_tin], stats[:supplier_response_50_tin], stats[:supplier_response_25_tin], stats[:supplier_response_1_tin], stats[:supplier_response_0_tin]], :style => [right_align, center_align, center_align]
        sheet.add_row ["Gold", stats[:supplier_response_100_gold], stats[:supplier_response_75_gold], stats[:supplier_response_50_gold], stats[:supplier_response_25_gold], stats[:supplier_response_1_gold], stats[:supplier_response_0_gold]], :style => [right_align, center_align, center_align]
        sheet.add_row ["Tungsten", stats[:supplier_response_100_tungsten], stats[:supplier_response_75_tungsten], stats[:supplier_response_50_tungsten], stats[:supplier_response_25_tungsten], stats[:supplier_response_1_tungsten], stats[:supplier_response_0_tungsten]], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting a Policy in Place", stats[:reported_policy_in_place], ("%.2f%%" % (stats[:reported_policy_in_place] / stats[:number_of_companies].to_f * 100.00))], :style => [h2, nil, nil]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting Their Policy is Available on Their Website", stats[:reported_policy_on_website], ("%.2f%%" % (stats[:reported_policy_on_website] / stats[:number_of_companies].to_f * 100.00))], :style => [h2, nil, nil]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Companies Reporting They Are Subject to the SEC Conflict Minerals rule", [:reported_subject_to_sec], ("%.2f%%" % (stats[:reported_subject_to_sec] / stats[:number_of_companies].to_f * 100.00))], :style => [h2, nil, nil]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Status", "", ""], :style => [h2, nil, nil]
        sheet.add_row ["Green", stats[:status_green], ("%.2f%%" % (stats[:status_green] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["High Risk", stats[:status_high_risk], ("%.2f%%" % (stats[:status_high_risk] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Validation Needed", stats[:status_validation_needed], ("%.2f%%" % (stats[:status_validation_needed] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]

        sheet.add_row ["", "", ""]
        sheet.add_row ["Reporting at", "", ""], :style => [h2, nil, nil]
        sheet.add_row ["Company level", stats[:scoped_at_company_level], ("%.2f%%" % (stats[:scoped_at_company_level] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Product level", stats[:scoped_at_product_level], ("%.2f%%" % (stats[:scoped_at_product_level] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
        sheet.add_row ["Other", stats[:scoped_at_other], ("%.2f%%" % (stats[:scoped_at_other] / stats[:number_of_companies].to_f * 100.00))], :style => [right_align, center_align, center_align]
      end
      sheet
    end

    def to_excel
      workbook = Axlsx::Workbook.new
      aggregated_declarations_worksheet(workbook)
      statistics_worksheet(workbook)
      Axlsx::Package.new :workbook => workbook
    end
  end
end
