class ReportsController < ApplicationController
  include ReportsHelper
  layout 'print', :only => 'generate_comprehensive'

  def list
  end

  def view
  end
  
  def comprehensive
    @reviews = (current_user) ? current_user.organization.reviews.sort_by(&:targeted_completion_at) : []
  end
  
  def generate_comprehensive
    @review = Review.includes({:tasks => :comments}).where(:id => params[:id], :organization_id => current_user.organization.id).first
  end
  
  require 'csv'
  def eicc_consolidated_report
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first
    
     @csv = CSV.generate do |csv|
       csv << ["Supplier Company Name",
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
                 "Question 1 - Tantalum",
                 "Question 1 Comments - Tantalum",
                 "Question 1 - Tin",
                 "Question 1 Comments - Tin",
                 "Question 1 - Gold",
                 "Question 1 Comments - Gold",
                 "Question 1 - Tungsten",
                 "Question 1 Comments - Tungsten",
                 
                 "Question 2 - Tantalum",
                 "Question 2 Comments - Tantalum",
                 "Question 2 - Tin",
                 "Question 2 Comments - Tin",
                 "Question 2 - Gold",
                 "Question 2 Comments - Gold",
                 "Question 2 - Tungsten",
                 "Question 2 Comments - Tungsten",
                 
                 "Question 3 - Tantalum",
                 "Question 3 Comments - Tantalum",
                 "Question 3 - Tin",
                 "Question 3 Comments - Tin",
                 "Question 3 - Gold",
                 "Question 3 Comments - Gold",
                 "Question 3 - Tungsten",
                 "Question 3 Comments - Tungsten",
                 
                 "Question 4 - Tantalum",
                 "Question 4 Comments - Tantalum",
                 "Question 4 - Tin",
                 "Question 4 Comments - Tin",
                 "Question 4 - Gold",
                 "Question 4 Comments - Gold",
                 "Question 4 - Tungsten",
                 "Question 4 Comments - Tungsten",
                 
                 "Question 5 - Tantalum",
                 "Question 5 Comments - Tantalum",
                 "Question 5 - Tin",
                 "Question 5 Comments - Tin",
                 "Question 5 - Gold",
                 "Question 5 Comments - Gold",
                 "Question 5 - Tungsten",
                 "Question 5 Comments - Tungsten",
                 
                 "Question 6 - Tantalum",
                 "Question 6 Comments - Tantalum",
                 "Question 6 - Tin",
                 "Question 6 Comments - Tin",
                 "Question 6 - Gold",
                 "Question 6 Comments - Gold",
                 "Question 6 - Tungsten",
                 "Question 6 Comments - Tungsten",
                 
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
                 
                 # Smelter list
                 "Number of standard smelter names provided - Tantalum",
                 "Number of 'Smelter not list' names provided - Tantalum",
                 "Number of 'Smelter not yet identified' names provided - Tantalum",
                 "Number of non-Conflict Free smelters - Tantalum",
                 "Number of standard smelter names provided - Tin",
                 "Number of 'Smelter not list' names provided - Tin",
                 "Number of 'Smelter not yet identified' names provided - Tin",
                 "Number of non-Conflict Free smelters - Tin",
                 "Number of standard smelter names provided - Gold",
                 "Number of 'Smelter not list' names provided - Gold",
                 "Number of 'Smelter not yet identified' names provided - Gold",
                 "Number of non-Conflict Free smelters - Gold",
                 "Number of standard smelter names provided - Tungsten",
                 "Number of 'Smelter not list' names provided - Tungsten",
                 "Number of 'Smelter not yet identified' names provided - Tungsten",
                 "Number of non-Conflict Free smelters - Tungsten",
                 
                 # Extra data                 
                 "Date Ingested into GSP",
                 "Original File Name",
                 "Validation Status",
                 "Issues"]
                 
      # Calculation totals
      calc_declaration_scopes = {:"Company level" => 0, :"Division level" => 0, :"Product category level" => 0, :"Product level" => 0, :"Empty" => 0}
      calc_company_unique_identified = {:"Provided" => 0, :"Not Provided" => 0}
      calc_address = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_name  = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_title = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_email = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_phone = {:"Provided" => 0, :"Not Provided" => 0}
      
      calc_minerals = [
                        {:tantalum => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
                         :tantalum_comment => {:"Provided comments" => 0, :"Did not provide comments" => 0},
                         :tin => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
                         :tin_comment => {:"Provided comments" => 0, :"Did not provide comments" => 0},
                         :gold => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
                         :gold_comment => {:"Provided comments" => 0, :"Did not provide comments" => 0},
                         :tungsten => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
                         :tungsten_comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}
                        }
                      
                      ] * 6
      
      calc_company_level = [{:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"Yes included in standard contract language" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"Planned once lists become available" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes (3rd party audit)" => 0, :"Yes (documentation review only)" => 0, :"Yes (internal audit)" => 0, :"Yes (all methods apply)" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}},
                            {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided comments" => 0, :"Did not provide comments" => 0}}
                           ]

      @batch.individual_validation_statuses.each do |ivs|
        next if ivs.declaration.nil?
        
        dec = ivs.declaration
        minerals = dec.mineral_questions.sort_by(&:sequence)
        company_level = dec.company_level_questions.sort_by(&:sequence)
        
        
        row = [dec.company_name,
               dec.declaration_scope,
               dec.description_of_scope,
               dec.company_unique_identifier,
               dec.address,
               dec.authorized_company_representative_name,
               dec.representative_title,
               dec.representative_email,
               dec.representative_phone,
               dec.completion_at]
               
         (0..5).to_a.each do |sequence|
          if minerals[sequence]
            mq = minerals[sequence]
            row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]
            
            case mq.tantalum.to_s.strip
              when "yes"
                calc_minerals[sequence][:tantalum][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tantalum][:"No"] += 1
              else
                calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
            end
            if mq.tantalum.to_s.empty?
              calc_minerals[sequence][:tantalum_comment][:"Provided comments"] += 1
            else
              calc_minerals[sequence][:tantalum_comment][:"Did not provide comments"] += 1
            end
            case mq.tin.to_s.strip
              when "yes"
                calc_minerals[sequence][:tin][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tin][:"No"] += 1
              else
                calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
            end
            if mq.tin.to_s.empty?
              calc_minerals[sequence][:tin_comment][:"Provided comments"] += 1
            else
              calc_minerals[sequence][:tin_comment][:"Did not provide comments"] += 1
            end
            case mq.gold.to_s.strip
              when "yes"
                calc_minerals[sequence][:gold][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:gold][:"No"] += 1
              else
                calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
            end
            if mq.gold.to_s.empty?
              calc_minerals[sequence][:gold_comment][:"Provided comments"] += 1
            else
              calc_minerals[sequence][:gold_comment][:"Did not provide comments"] += 1
            end
            case mq.tungsten.to_s.strip
              when "yes"
                calc_minerals[sequence][:tungsten][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tungsten][:"No"] += 1
              else
                calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
            end
            if mq.tungsten.to_s.empty?
              calc_minerals[sequence][:tungsten_comment][:"Provided comments"] += 1
            else
              calc_minerals[sequence][:tungsten_comment][:"Did not provide comments"] += 1
            end
            
          else
            row += [''] * 8
            
          end
         end
         
         (0..9).to_a.each do |sequence|
          if company_level[sequence]
            clq = company_level[sequence]
            row += [clq.answer, clq.comment]
            
            case sequence
              when 0
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 1
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 2
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "yes included in standard contract language"
                    calc_company_level[sequence][:answer][:"Yes included in standard contract language"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 3
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "planned once lists become available"
                    calc_company_level[sequence][:answer][:"Planned once lists become available"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 4
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 5
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 6
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 7
                case clq.answer.to_s.strip
                  when "yes (3rd party audit)"
                    calc_company_level[sequence][:answer][:"Yes (3rd party audit)"] += 1
                  when "yes (documentation review only)"
                    calc_company_level[sequence][:answer][:"Yes (documentation review only)"] += 1
                  when "yes (internal audit)"
                    calc_company_level[sequence][:answer][:"Yes (internal audit)"] += 1
                  when "yes (all methods apply)"
                    calc_company_level[sequence][:answer][:"Yes (all methods apply)"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 8
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
              when 9
                case clq.answer.to_s.strip
                  when "yes"
                    calc_company_level[sequence][:answer][:"Yes"] += 1
                  when "no"
                    calc_company_level[sequence][:answer][:"No"] += 1
                  else
                    calc_company_level[sequence][:answer][:"No answer provided"] += 1
                end
            end
            
            if clq.comment.to_s.strip.empty?
              calc_company_level[sequence][:comment][:"Did not provide comments"] += 1
            else
              calc_company_level[sequence][:comment][:"Provided comments"] += 1
            end
            
          else
            row += ["", ""]
          end
         end
         
         # Smelter list
         smelter_group_tantalum = {:identified => [], :not_yet_identified => [], :not_listed => [], :empty => []}
         smelter_group_tin      = {:identified => [], :not_yet_identified => [], :not_listed => [], :empty => []}
         smelter_group_gold     = {:identified => [], :not_yet_identified => [], :not_listed => [], :empty => []}
         smelter_group_tungsten = {:identified => [], :not_yet_identified => [], :not_listed => [], :empty => []}
         
         dec.smelter_list.sort_by(&:line_number).each do |smelter|
          case smelter.metal.to_s.downcase
            when 'tantalum'
              case smelter.smelter_reference_list.to_s.downcase
                when 'smelter not yet identified'
                  smelter_group_tantalum[:not_yet_identified] << smelter
                when 'smelter not listed'
                  smelter_group_tantalum[:not_listed] << smelter
                when ''
                  smelter_group_tantalum[:empty] << smelter
                else
                  smelter_group_tantalum[:identified] << smelter
              end
              
            when 'tin'
              case smelter.smelter_reference_list.to_s.downcase
                when 'smelter not yet identified'
                  smelter_group_tin[:not_yet_identified] << smelter
                when 'smelter not listed'
                  smelter_group_tin[:not_listed] << smelter
                when ''
                  smelter_group_tin[:empty] << smelter
                else
                  smelter_group_tin[:identified] << smelter
              end
            
            when 'gold'
              case smelter.smelter_reference_list.to_s.downcase
                when 'smelter not yet identified'
                  smelter_group_gold[:not_yet_identified] << smelter
                when 'smelter not listed'
                  smelter_group_gold[:not_listed] << smelter
                when ''
                  smelter_group_gold[:empty] << smelter
                else
                  smelter_group_gold[:identified] << smelter
              end
            
            when 'tungsten'
              case smelter.smelter_reference_list.to_s.downcase
                when 'smelter not yet identified'
                  smelter_group_tungsten[:not_yet_identified] << smelter
                when 'smelter not listed'
                  smelter_group_tungsten[:not_listed] << smelter
                when ''
                  smelter_group_tungsten[:empty] << smelter
                else
                  smelter_group_tungsten[:identified] << smelter
              end

          end
         end
         
         row += [smelter_group_tantalum[:identified].size, smelter_group_tantalum[:not_listed].size, smelter_group_tantalum[:not_yet_identified].size, '']
         row += [smelter_group_tin[:identified].size, smelter_group_tin[:not_listed].size, smelter_group_tin[:not_yet_identified].size, '']
         row += [smelter_group_gold[:identified].size, smelter_group_gold[:not_listed].size, smelter_group_gold[:not_yet_identified].size, '']
         row += [smelter_group_tungsten[:identified].size, smelter_group_tungsten[:not_listed].size, smelter_group_tungsten[:not_yet_identified].size, '']
         
         # Extra data
         row += [dec.created_at, dec.uploaded_excel.filename, ivs.status, ivs.message.gsub(/(<li>|<\/li>)/, "")]
         
         csv << row
       end
       
       
    
        # Counts
        csv << ["",
            "%d Company level - %d Division level - %d Product category level - %d Product level" % [calc_declaration_scopes[:"Company level"], calc_declaration_scopes[:"Division level"], calc_declaration_scopes[:"Product category level"], calc_declaration_scopes[:"Product level"]],
            "",
            "%d Provided - %d Not Provided" % [calc_company_unique_identified[:"Provided"], calc_company_unique_identified[:"Not Provided"]],
            "%d Provided - %d Not Provided" % [calc_address[:"Provided"], calc_address[:"Not Provided"]],
            "%d Provided - %d Not Provided" % [calc_representative_name[:"Provided"], calc_representative_name[:"Not Provided"]],
            "%d Provided - %d Not Provided" % [calc_representative_title[:"Provided"], calc_representative_title[:"Not Provided"]],
            "%d Provided - %d Not Provided" % [calc_representative_email[:"Provided"], calc_representative_email[:"Not Provided"]],
            "%d Provided - %d Not Provided" % [calc_representative_phone[:"Provided"], calc_representative_phone[:"Not Provided"]],
            "",
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[0][:tantalum][:"Yes"], calc_minerals[0][:tantalum][:"No"], calc_minerals[0][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[0][:tantalum_comment][:"Provided comments"], calc_minerals[0][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[0][:tin][:"Yes"], calc_minerals[0][:tin][:"No"], calc_minerals[0][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[0][:tin_comment][:"Provided comments"], calc_minerals[0][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[0][:gold][:"Yes"], calc_minerals[0][:gold][:"No"], calc_minerals[0][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[0][:gold_comment][:"Provided comments"], calc_minerals[0][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[0][:tungsten][:"Yes"], calc_minerals[0][:tungsten][:"No"], calc_minerals[0][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[0][:tungsten_comment][:"Provided comments"], calc_minerals[0][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[1][:tantalum][:"Yes"], calc_minerals[1][:tantalum][:"No"], calc_minerals[1][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[1][:tantalum_comment][:"Provided comments"], calc_minerals[1][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[1][:tin][:"Yes"], calc_minerals[1][:tin][:"No"], calc_minerals[1][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[1][:tin_comment][:"Provided comments"], calc_minerals[1][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[1][:gold][:"Yes"], calc_minerals[1][:gold][:"No"], calc_minerals[1][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[1][:gold_comment][:"Provided comments"], calc_minerals[1][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[1][:tungsten][:"Yes"], calc_minerals[1][:tungsten][:"No"], calc_minerals[1][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[1][:tungsten_comment][:"Provided comments"], calc_minerals[1][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[2][:tantalum][:"Yes"], calc_minerals[2][:tantalum][:"No"], calc_minerals[2][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[2][:tantalum_comment][:"Provided comments"], calc_minerals[2][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[2][:tin][:"Yes"], calc_minerals[2][:tin][:"No"], calc_minerals[2][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[2][:tin_comment][:"Provided comments"], calc_minerals[2][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[2][:gold][:"Yes"], calc_minerals[2][:gold][:"No"], calc_minerals[2][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[2][:gold_comment][:"Provided comments"], calc_minerals[2][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[2][:tungsten][:"Yes"], calc_minerals[2][:tungsten][:"No"], calc_minerals[2][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[2][:tungsten_comment][:"Provided comments"], calc_minerals[2][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[3][:tantalum][:"Yes"], calc_minerals[3][:tantalum][:"No"], calc_minerals[3][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[3][:tantalum_comment][:"Provided comments"], calc_minerals[3][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[3][:tin][:"Yes"], calc_minerals[3][:tin][:"No"], calc_minerals[3][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[3][:tin_comment][:"Provided comments"], calc_minerals[3][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[3][:gold][:"Yes"], calc_minerals[3][:gold][:"No"], calc_minerals[3][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[3][:gold_comment][:"Provided comments"], calc_minerals[3][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[3][:tungsten][:"Yes"], calc_minerals[3][:tungsten][:"No"], calc_minerals[3][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[3][:tungsten_comment][:"Provided comments"], calc_minerals[3][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[4][:tantalum][:"Yes"], calc_minerals[4][:tantalum][:"No"], calc_minerals[4][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[4][:tantalum_comment][:"Provided comments"], calc_minerals[4][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[4][:tin][:"Yes"], calc_minerals[4][:tin][:"No"], calc_minerals[4][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[4][:tin_comment][:"Provided comments"], calc_minerals[4][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[4][:gold][:"Yes"], calc_minerals[4][:gold][:"No"], calc_minerals[4][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[4][:gold_comment][:"Provided comments"], calc_minerals[4][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[4][:tungsten][:"Yes"], calc_minerals[4][:tungsten][:"No"], calc_minerals[4][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[4][:tungsten_comment][:"Provided comments"], calc_minerals[4][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[5][:tantalum][:"Yes"], calc_minerals[5][:tantalum][:"No"], calc_minerals[5][:tantalum][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[5][:tantalum_comment][:"Provided comments"], calc_minerals[5][:tantalum_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[5][:tin][:"Yes"], calc_minerals[5][:tin][:"No"], calc_minerals[5][:tin][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[5][:tin_comment][:"Provided comments"], calc_minerals[5][:tin_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[5][:gold][:"Yes"], calc_minerals[5][:gold][:"No"], calc_minerals[5][:gold][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[5][:gold_comment][:"Provided comments"], calc_minerals[5][:gold_comment][:"Did not provide comments"]],
            "%d Yes - %d No - %d No Answer Provided" % [calc_minerals[5][:tungsten][:"Yes"], calc_minerals[5][:tungsten][:"No"], calc_minerals[5][:tungsten][:"No Answer Provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_minerals[5][:tungsten_comment][:"Provided comments"], calc_minerals[5][:tungsten_comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[0][:answer][:"Yes"], calc_company_level[0][:answer][:"No"], calc_company_level[0][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[0][:comment][:"Provided comments"], calc_company_level[0][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[1][:answer][:"Yes"], calc_company_level[1][:answer][:"No"], calc_company_level[1][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[1][:comment][:"Provided comments"], calc_company_level[1][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d Yes included in standard contract language - %d No - %d No answer provided" % [calc_company_level[2][:answer][:"Yes"], calc_company_level[2][:answer][:"Yes included in standard contract language"], calc_company_level[2][:answer][:"No"], calc_company_level[2][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[2][:comment][:"Provided comments"], calc_company_level[2][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d Planned once lists become available - %d No - %d No answer provided" % 
              [calc_company_level[3][:answer][:"Yes"], calc_company_level[3][:answer][:"Planned once lists become available"], calc_company_level[3][:answer][:"No"], calc_company_level[3][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[3][:comment][:"Provided comments"], calc_company_level[3][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[4][:answer][:"Yes"], calc_company_level[4][:answer][:"No"], calc_company_level[4][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[4][:comment][:"Provided comments"], calc_company_level[4][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[5][:answer][:"Yes"], calc_company_level[5][:answer][:"No"], calc_company_level[5][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[5][:comment][:"Provided comments"], calc_company_level[5][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[6][:answer][:"Yes"], calc_company_level[6][:answer][:"No"], calc_company_level[6][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[6][:comment][:"Provided comments"], calc_company_level[6][:comment][:"Did not provide comments"]],
            
            "%d Yes (3rd party audit) - %d Yes (documentation review only) - %d Yes (internal audit) - %d Yes (all methods apply) - %d No - %d No answer provided" %
              [calc_company_level[7][:answer][:"Yes (3rd party audit)"],
               calc_company_level[7][:answer][:"Yes (documentation review only)"],
               calc_company_level[7][:answer][:"Yes (internal audit)"],
               calc_company_level[7][:answer][:"Yes (all methods apply)"],
               calc_company_level[7][:answer][:"No"],
               calc_company_level[7][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[7][:comment][:"Provided comments"], calc_company_level[7][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[8][:answer][:"Yes"], calc_company_level[8][:answer][:"No"], calc_company_level[8][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[8][:comment][:"Provided comments"], calc_company_level[8][:comment][:"Did not provide comments"]],
            
            "%d Yes - %d No - %d No answer provided" % [calc_company_level[9][:answer][:"Yes"], calc_company_level[9][:answer][:"No"], calc_company_level[9][:answer][:"No answer provided"]],
            "%d Provided comments - %d Did not provide comments" % [calc_company_level[9][:comment][:"Provided comments"], calc_company_level[9][:comment][:"Did not provide comments"]]
             
            ]
       
    end
    
    send_data @csv, :filename => report_filename("eicc_consolidated_report.gsp.csv"), :type => 'application/csv'
  end
  
  def eicc_detailed_smelter_report
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first
    
    @csv = CSV.generate do |csv|
      csv << ["Supplier Company Name",
              # these columns are taken from the declaration, except product list which is an array created from the product list tab
              "Declaration of Scope",
              "Description of Scope",
              # "Product List",
              "Company Unique Identifier",
              "Address",
              "Authorized Company Representative Name",
              "Representative Title",
              "Representative E-Mail",
              "Representative Phone",
              "Date of Completion",
              "Question 1 - Tantalum",
              "Question 1 Comments - Tantalum",
              "Question 1 - Tin",
              "Question 1 Comments - Tin",
              "Question 1 - Gold",
              "Question 1 Comments - Gold",
              "Question 1 - Tungsten",
              "Question 1 Comments - Tungsten",
              "Date Ingested into GSP",
              "Original File Name",
              "Validation Status",
              # The following repeat for each non-null line in the smelter list
              "Metal", 
              "Smelter Reference List", 
              "Standard Smelter Names", 
              "Smelter Facility Location Country", 
              "Smelter ID", 
              "Smelter Facility Location Street address", 
              "Smelter Facility Location City", 
              "Smelter Facility Location State Province", 
              "Smelter Facility Contact Name", 
              "Smelter Facility Contact Email", 
              "Proposed next steps, if applicable", 
              "Name of Mines or if recycled or scrap sourced, state recycled or scrap", 
              "Location of Mines or if recycled or scrap sourced, state recycled or scrap", 
              "Comments" 
              ]
      @batch.individual_validation_statuses.each do |ivs|
        next if ivs.declaration.nil?
        
        dec = ivs.declaration
        question_1 = dec.mineral_questions.sort_by(&:sequence).first
        
        row_first_part = [dec.company_name,
                          dec.declaration_scope,
                          dec.description_of_scope,
                          dec.company_unique_identifier,
                          dec.address,
                          dec.authorized_company_representative_name,
                          dec.representative_title,
                          dec.representative_email,
                          dec.representative_phone,
                          dec.completion_at,
                          question_1.tantalum,
                          question_1.tantalum_comment,
                          question_1.tin,
                          question_1.tin_comment,
                          question_1.gold,
                          question_1.gold_comment,
                          question_1.tungsten,
                          question_1.tungsten_comment,
                          dec.created_at,
                          dec.uploaded_excel.filename,
                          ivs.status]

        if dec.smelter_list.nil?
          csv << row_first_part + ([''] * 13)
        else
          dec.smelter_list.each do |smelter|
            row_second_part = [smelter.metal,
                               smelter.smelter_reference_list,
                               smelter.standard_smelter_name,
                               smelter.facility_location_country,
                               smelter.smelter_id,
                               smelter.facility_location_street_address,
                               smelter.facility_location_city,
                               smelter.facility_location_province,
                               smelter.facility_contact_name,
                               smelter.facility_contact_email,
                               smelter.proposed_next_steps,
                               smelter.mineral_source,
                               smelter.mineral_source_location,
                               smelter.comment]
                    
            row = row_first_part + row_second_part    
            csv << row       
          end
        end
        
      end
    end
    
   send_data @csv, :filename => report_filename("eicc_detailed_smelter_list_report.gsp.csv"), :type => 'application/csv'
  end
  
  def eicc_consolidated_smelter_list
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first
    
    smelters = {}
    
    @batch.individual_validation_statuses.each do |ivs|
      next if ivs.declaration.nil?
      dec = ivs.declaration
      
      ext_supplier_name = [dec.company_name, dec.declaration_scope, dec.description_of_scope].join(" ")
      
      dec.smelter_list.each do |smelter|
        smelter_key = [smelter.metal.to_s.strip, smelter.smelter_reference_list.to_s.strip, smelter.standard_smelter_name.to_s.strip, smelter.facility_location_country.to_s.strip, smelter.smelter_id.to_s.strip].join('=;=')
        smelters[smelter_key] = [] if smelters[smelter_key].nil?
        smelters[smelter_key] << ext_supplier_name
      end
    end
    
    @csv = CSV.generate do |csv|
      csv << ["Metal",
              "Smelter Reference List",
              "Standard Smelter Names",
              "Smelter Facility Location Country",
              "Smelter ID",
              "Number of Suppliers",
              "Supplier Names"]
              
      smelters.each do |key, value|
        smelter_info = key.split('=;=')
        csv << [smelter_info[0],
                smelter_info[1],
                smelter_info[2],
                smelter_info[3],
                value.uniq.size,
                value.uniq.join(', ')]
      end
    end
    
   send_data @csv, :filename => report_filename("eicc_consolidated_smelter_list_report.gsp.csv"), :type => 'application/csv'
  end
  
  
  # Dashboard graphs
  def review_status
    @graph_image_url = Gchart.pie(:size => '400x400', 
                                  :title => "Reviews",
                                  :bg => 'efefef',
                                  :legend => ['Completed', 'Not Completed'],
                                  :data => [4, 6])
  end
  
  def task_status
  end
  
  def task_findings
  end
end
