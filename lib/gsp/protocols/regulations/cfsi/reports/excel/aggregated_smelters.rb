module GSP::Protocols::Regulations::CFSI::Reports::Excel
  class AggregatedSmelters < Report
    def aggregated_smelters
      {:name => "Aggregated CMRTs",
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
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q1-V3: Is the conflict metal intentionally added to your product?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q1 - V2: Are any of the following metals necessary to the functionality or production of your company's products that it manufacturers or contracts to manufacture?\n\n Q2-V3: Is the conflict metal necessary to the production of your company's product and contained in the finished product that your company manufactures or contracts to manufacture?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q2 - V2: Do the following metals (necessary to the functionality or production of your company's products) originate frrom the DRC or an adjoining country?\n\nQ3 -V3: Does any of the conflict metal originate from the covered countries?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q3 - V2: Do the following metals (necessary to the functionality or production of your company's products) come from a recycler or scrap supplier? \n\nQ4 - V3: Does 100 percent of the conflict metal (necessary to the functionality or production of your products) originate from recylcled or scrap sources?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q4 - V2: Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?\n\nQ5 - V3: Have you received conflict metals data/information for each metal from all relevant suppliears of 3TG?"},
                   {:name => "Tantalum Comments", :column_width => 40, :question => ""},
                   {:name => "Tin (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tin Comments", :column_width => 40, :question => ""},
                   {:name => "Gold (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Gold Comments", :column_width => 40, :question => ""},
                   {:name => "Tungsten (Y/N)", :column_width => 15, :question => ""},
                   {:name => "Tungsten Comments", :column_width => 40, :question => ""},
                   {:name => "Tantalum (Y/N)", :column_width => 15, :question => "Q5 - V2: For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope?\n\nQ6 - V3: For each conflict mineral, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope?"},
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
                   {:name => "Question B", :column_width => 15, :question => "QB -V2: QB - V3: Is this policy publicly available on your wewbsite?\n\nQB - V3: Is your conflict minerals sourcing policy publicly available on your wewbsite? (Note: If yes, the user shall specify the URL in the comment field.)"},
                   {:name => "Question B Comments", :column_width => 40, :question => ""},
                   {:name => "Question C", :column_width => 15, :question => "QC - V2&3: Do you require your direct suppliers to be DRC Conflict Free?"},
                   {:name => "Question C Comments", :column_width => 40, :question => ""},
                   {:name => "Question D", :column_width => 15, :question => "QD - V2: Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?\n\nQD - V3: Do you require your direct suppliers to source from smelterss validated by an independent private sector audit firm?"},
                   {:name => "Question D Comments", :column_width => 40, :question => ""},
                   {:name => "Question E", :column_width => 15, :question => "QE - V2&3: Have you implemented due diligence measures for conflict-free sourcing?"},
                   {:name => "Question E Comments", :column_width => 40, :question => ""},
                   {:name => "Question F", :column_width => 15, :question => "QF -V2 Do you requst your suppliers to fill out this Conflict Minerals Reporting Template?\n\nQF - V3: Do you collect conflict minerals due diligence information from your suppliers which is in conformance with the IPC-1755 Conflict Minerals Data Exchange standard [e.g. CFSI Conflict Minerals Reporting  Template]?"},
                   {:name => "Question F Comments", :column_width => 40, :question => ""},
                   {:name => "Question G", :column_width => 15, :question => "QG - V2&3: Do you request smelter names from your suppliers?"},
                   {:name => "Question G Comments", :column_width => 40, :question => ""},
                   {:name => "Question H", :column_width => 15, :question => "QH - V2: Do you verify due diligence information received from your suppliers?\n\nQH - V3: Do you review due diligence information received from your suppliers against your company's expectations?"},
                   {:name => "Question H Comments", :column_width => 40, :question => ""},
                   {:name => "Question I", :column_width => 15, :question => "QI - V2: Does your verification process include corrective action management?\n\nQI - V3: Does your review process include corrective action management?"},
                   {:name => "Question I Comments", :column_width => 40, :question => ""},
                   {:name => "Question J", :column_width => 15, :question => "QJ - V2: Are you subject to the SEC Conflict Minerals disclosure requirement rule?\n\nQJ - V3: Are you subject to the SEC Conflict Minerals rule?"},
                   {:name => "Question J Comments", :column_width => 40, :question => ""},

                   # Misc
                   {:name => "Uploaded At", :column_width => 20},
                   {:name => "CMRT File Name", :column_width => 20},
                   {:name => "CFSI Template Version", :column_width => 20},
                   {:name => "Status", :column_width => 20},
                   {:name => "Issues", :column_width => 200}],
       :data => validations_batch.cmrt_validations.collect do |val|
                  next unless val.has_declaration?
                  dec = val.cmrt.declaration
                  row = [dec.company_name,
                         dec.declaration_scope,
                         dec.description_of_scope,
                         dec.company_unique_identifier,
                         dec.address,
                         dec.authorized_company_representative_name,
                         dec.contact_title,
                         dec.contact_email,
                         dec.contact_phone,
                         dec.completion_at.nil? ? "" : dec.completion_at.strftime('%B %d, %Y')]
                  dec.minerals_questions.each do |mq|
                    row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]
                  end
                  dec.company_level_questions.each do |clq|
                    row += [clq.answer, clq.comment]
                  end
                  row += [dec.created_at.to_formatted_s(:local), val.file_name,  dec.version, val.status, val.issues.to_s.gsub(/(<li>|<\/li>)/, "; ")]
                end
      }
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

      worksheet.merge_cells "BL1:BM1"
      worksheet.merge_cells "BN1:BO1"
      worksheet.merge_cells "BP1:BQ1"
      worksheet.merge_cells "BR1:BS1"
      worksheet.merge_cells "BT1:BU1"
      worksheet.merge_cells "BV1:BW1"

      worksheet.merge_cells "BX1:BY1"
      worksheet.merge_cells "BZ1:CA1"
      worksheet.merge_cells "CB1:CC1"
      worksheet.merge_cells "CD1:CE1"
      worksheet.merge_cells "CF1:CG1"

      worksheet.add_row(["", "",[worksheet.name,
                                "%s: %s" % ["Co.".rjust(6, ' '), 'current_user.organization.full_name'],
                                "%s: %s" % ["Date".rjust(6, ' '), Date.today],
                                "%s: %s" % ["Time".rjust(6, ' '), Time.now.strftime("%H:%M:%S")],
                                "%s: %s" % ["User".rjust(6, ' '), 'current_user.eponym']
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

    def to_excel
      self.worksheets = [aggregated_smelters]
      @questions = worksheets.first[:header].collect { |h| h[:question] }.compact
      super
    end
  end
end
