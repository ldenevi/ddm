class ReportsController < ApplicationController
  layout 'print', :only => 'generate_comprehensive'

  def list
  end

  def view
  end
  
  def comprehensive
    @reviews = (current_user) ? current_user.organization.reviews.sort_by(&:targeted_completion_at) : []
  end
  
  def generate_comprehensive
    @review = Review.includes({:tasks => :comments}).where(:id => params[:id]).first
  end
  
  require 'csv'
  def eicc_consolidated_report
    @batch = Eicc::BatchValidationStatus.find(params[:id])
    
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
          else
            row += [''] * 8
          end
         end
         
         (0..9).to_a.each do |sequence|
          if company_level[sequence]
            clq = company_level[sequence]
            row += [clq.answer, clq.comment]
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
    end
    
    send_data @csv, :filename => "eicc_consolidated_report.gsp.csv", :type => 'application/csv'
  end
  
  def eicc_detailed_smelter_report
    @batch = Eicc::BatchValidationStatus.find(params[:id])
    
    csv = CSV.generate do |csv|
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
    
   send_data csv, :filename => "eicc_detailed_smelter_list_report.gsp.csv", :type => 'application/csv'
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
