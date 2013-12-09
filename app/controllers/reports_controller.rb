class ReportsController < ApplicationController
  include ReportsHelper
  layout 'print', :only => 'generate_comprehensive'

  require 'axlsx'
  
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


  def eicc_consolidated_report
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first

    rows = []
      header = ["   #   ",
	      "Supplier Company Name",
              "Declaration Scope",
              "Description of Scope", #remember to add Product List
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

              # Smelter list
              "Number of standard smelter names provided - Tantalum",
              "Number of 'Smelter not listed' names provided - Tantalum",
              "Number of 'Smelter not yet identified' names provided - Tantalum",
               "Number of standard smelter names provided - Tin",
              "Number of 'Smelter not listed' names provided - Tin",
              "Number of 'Smelter not yet identified' names provided - Tin",
              "Number of standard smelter names provided - Gold",
              "Number of 'Smelter not listed' names provided - Gold",
              "Number of 'Smelter not yet identified' names provided - Gold",
              "Number of standard smelter names provided - Tungsten",
              "Number of 'Smelter not listed' names provided - Tungsten",
              "Number of 'Smelter not yet identified' names provided - Tungsten",
              # Extra data                 
              "Date Ingested into GSP",
              "File Name",
              "Validation Status",
              "Issues"]     #finished writing header row - will add to next rows in ivs declaration loop  and then write final total row unless we move totals higher

      # Calculation totals initialization to 0
      calc_company_name = {:"Provided" => 0, :"Not Provided" => 0}
      calc_declaration_scope = {:"Company level" => 0, :"Division level" => 0, :"Product category level" => 0, :"Product level" => 0, :"Not Provided" => 0}
      calc_description_of_scope = {:"Provided" => 0, :"Not Provided" => 0}
      calc_company_unique_identifier = {:"Provided" => 0, :"Not Provided" => 0}
      calc_address = {:"Provided" => 0, :"Not Provided" => 0}
      calc_authorized_company_representative_name  = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_title = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_email = {:"Provided" => 0, :"Not Provided" => 0}
      calc_representative_phone = {:"Provided" => 0, :"Not Provided" => 0}
      calc_completion_at = {:"Provided" => 0, :"Not Provided" => 0}

      calc_minerals = [
          {:tantalum => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
           :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
           :tin => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
           :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
           :gold => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
           :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
           :tungsten => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0},
           :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
          }
    #sequence 0 - minerals question 1 above
      ]  + [
            {:tantalum => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tin => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :gold => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tungsten => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
            }
            #sequence 1 - minerals question 2 above 
            ]  + [
            {:tantalum => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tin => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :gold => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tungsten => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Uncertain or Unknown" => 0},
                 :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
            }
            #sequence 2 - minerals question 3 above
            ]  + [
            {:tantalum => {:"Yes" => 0, :"No but > 75%" => 0, :"No but > 50%" => 0, :"No but > 25%" => 0, :"No but < 25%" => 0, :"No - None" => 0,  :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tin => {:"Yes" => 0, :"No but > 75%" => 0, :"No but > 50%" => 0, :"No but > 25%" => 0, :"No but < 25%" => 0, :"No - None" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :gold => {:"Yes" => 0, :"No but > 75%" => 0, :"No but > 50%" => 0, :"No but > 25%" => 0, :"No but < 25%" => 0, :"No - None" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tungsten => {:"Yes" => 0, :"No but > 75%" => 0, :"No but > 50%" => 0, :"No but > 25%" => 0, :"No but < 25%" => 0, :"No - None" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
            }
                 #sequence 3 - minerals question 4 above
            ]  + [
            {:tantalum => {:"Yes all smelters have been provided" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tin => {:"Yes all smelters have been provided" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :gold => {:"Yes all smelters have been provided" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tungsten => {:"Yes all smelters have been provided" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0},
                 :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
            }
                  #sequence 4 - minerals question 5 above
            ]  + [
            {:tantalum => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Unknown" => 0},
                 :tantalum_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tin => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Unknown" => 0},
                 :tin_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :gold => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Unknown" => 0},
                 :gold_comment => {:"Provided" => 0, :"Not Provided" => 0},
                 :tungsten => {:"Yes" => 0, :"No" => 0, :"No Answer Provided" => 0,  :"Answer not Required" => 0,  :"Unknown" => 0},
                 :tungsten_comment => {:"Provided" => 0, :"Not Provided" => 0}
            }
                   #sequence 5 - minerals question 6 above
            ]



      calc_company_level = [{:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"Yes included in standard contract language" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"Planned once lists become available" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes (3rd party audit)" => 0, :"Yes (documentation review only)" => 0, :"Yes (internal audit)" => 0, :"Yes (all methods apply)" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}},
              {:answer => {:"Yes" => 0, :"No" => 0, :"No answer provided" => 0}, :comment => {:"Provided" => 0, :"Not Provided" => 0}}
             ]
    
    @batch.individual_validation_statuses.each do |ivs|    # beginning of declaration loop
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
      dec.representative_phone]
      completed_at_date = 0
      if dec.completion_at.nil? then completed_at_date = "No Date Given" else completed_at_date = dec.completion_at.strftime('%B %d, %Y') end    # dec.completion_at.strftime('%d, %B, %Y')(:local)]
      row = row + [completed_at_date]
	
	# add calc totals for this loop

	if dec.company_name.to_s.strip.empty?
		calc_company_name[:"Not Provided"] += 1
	else
		calc_company_name[:"Provided"] += 1
	end
	


	case dec.declaration_scope	
	  when /^A./
	    calc_declaration_scope[:"Company level"] += 1
	  when /^B./
              calc_declaration_scope[:"Division level"] += 1
	  when /^C./
             calc_declaration_scope[:"Product category level"] += 1
          when /^D./
             calc_declaration_scope[:"Product level"] += 1
          else
	    calc_declaration_scope[:"Not Provided"] += 1
        end
      
	       
	if dec.description_of_scope.to_s.strip.empty?
		calc_description_of_scope[:"Not Provided"] += 1
	else
		calc_description_of_scope[:"Provided"] += 1
	end
	
	if dec.address.to_s.strip.empty?
		calc_address[:"Not Provided"] += 1
	else
		calc_address[:"Provided"] += 1
	end

	if dec.company_unique_identifier.to_s.strip.empty?
		calc_company_unique_identifier[:"Not Provided"] += 1
	else
		calc_company_unique_identifier[:"Provided"] += 1
	end
	
	if dec.address.to_s.strip.empty?
		calc_address[:"Not Provided"] += 1
	else
		calc_address[:"Provided"] += 1
	end


	if dec.authorized_company_representative_name.to_s.strip.empty?
		calc_authorized_company_representative_name[:"Not Provided"] += 1
	else
		calc_authorized_company_representative_name[:"Provided"] += 1
	end


	if dec.representative_title .to_s.strip.empty?
		calc_representative_title [:"Not Provided"] += 1
	else
		calc_representative_title [:"Provided"] += 1
	end


	if dec.representative_email.to_s.strip.empty?
		calc_representative_email[:"Not Provided"] += 1
	else
		calc_representative_email[:"Provided"] += 1
	end


	if dec.representative_phone.to_s.strip.empty?
		calc_representative_phone[:"Not Provided"] += 1
	else
		calc_representative_phone[:"Provided"] += 1
	end


	if dec.completion_at.to_s.strip.empty?
		calc_completion_at[:"Not Provided"] += 1
	else
		calc_completion_at[:"Provided"] += 1
	end

      # end of new insertions for calc totals

      (0..0).to_a.each do |sequence|         
        if minerals[sequence]
          mq = minerals[sequence]
          row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

          case mq.tantalum.to_s.strip.downcase
            when "yes"
             calc_minerals[sequence][:tantalum][:"Yes"] += 1
            when "no"
             calc_minerals[sequence][:tantalum][:"No"] += 1
            else
             calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
          end
          
          if mq.tantalum_comment.to_s.strip.empty?
           calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
          else
           calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
          end
          
          case mq.tin.to_s.strip.downcase
            when "yes"
             calc_minerals[sequence][:tin][:"Yes"] += 1
            when "no"
             calc_minerals[sequence][:tin][:"No"] += 1
            else
             calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
          end
          
          if mq.tin_comment.to_s.strip.empty?
           calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
          else
           calc_minerals[sequence][:tin_comment][:"Provided"] += 1
          end
          
          case mq.gold.to_s.strip.downcase
            when "yes"
              calc_minerals[sequence][:gold][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:gold][:"No"] += 1
            else
              calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
          end
          
          if mq.gold_comment.to_s.strip.empty?
            calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:gold_comment][:"Provided"] += 1
          end
          
          case mq.tungsten.to_s.strip.downcase
            when "yes"
              calc_minerals[sequence][:tungsten][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:tungsten][:"No"] += 1
            else
              calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
          end
          
          if mq.tungsten_comment.to_s.strip.empty?
           calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
          else
           calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
          end
          
        end
      end



      (1..1).to_a.each do |sequence|         
        mq = minerals[sequence]
        row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

        if minerals[0].tantalum.to_s.strip.downcase == "no" 
          calc_minerals[sequence][:tantalum][:"Answer not Required"] += 1
        else  
          case mq.tantalum.to_s.strip.downcase
            when "yes"
             calc_minerals[sequence][:tantalum][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:tantalum][:"No"] += 1
            when "uncertain or unknown"
              calc_minerals[sequence][:tantalum][:"Uncertain or Unknown"] += 1
            else
              calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
          end
        end
        
        if mq.tantalum_comment.to_s.strip.empty?
          calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
        else
          calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
        end
        
        if minerals[0].tin.to_s.strip.downcase == "no" 
         calc_minerals[sequence][:tin][:"Answer not Required"] += 1
        else 
          case mq.tin.to_s.strip.downcase
            when "yes"
             calc_minerals[sequence][:tin][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:tin][:"No"] += 1
            when "uncertain or unknown"
              calc_minerals[sequence][:tin][:"Uncertain or Unknown"] += 1
            else
             calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
          end
        end
        
        if mq.tin_comment.to_s.strip.empty?
          calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
        else
          calc_minerals[sequence][:tin_comment][:"Provided"] += 1
        end
        
        if minerals[0].gold.to_s.strip.downcase == "no" 
          calc_minerals[sequence][:gold][:"Answer not Required"] += 1
        else
          case mq.gold.to_s.strip.downcase
            when "yes"
             calc_minerals[sequence][:gold][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:gold][:"No"] += 1
            when "uncertain or unknown"
             calc_minerals[sequence][:gold][:"Uncertain or Unknown"] += 1
            else
              calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
          end
        end
        
        if mq.gold_comment.to_s.strip.empty?
          calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
        else
          calc_minerals[sequence][:gold_comment][:"Provided"] += 1
        end
        
        if minerals[0].tungsten.to_s.strip.downcase == "no" 
          calc_minerals[sequence][:tungsten][:"Answer not Required"] += 1
        else
          case mq.tungsten.to_s.strip.downcase
            when "yes"
              calc_minerals[sequence][:tungsten][:"Yes"] += 1
            when "no"
              calc_minerals[sequence][:tungsten][:"No"] += 1
            when "uncertain or unknown"
              calc_minerals[sequence][:tungsten][:"Uncertain or Unknown"] += 1
            else
              calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
          end
        end
        
        if mq.tungsten_comment.to_s.strip.empty?
          calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
        else
          calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
        end
      end


      (2..2).to_a.each do |sequence|         
        if minerals[sequence]
          mq = minerals[sequence]
          row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

          if minerals[0].tantalum.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tantalum][:"Answer not Required"] += 1
          else
            case mq.tantalum.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tantalum][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tantalum][:"No"] += 1
              when "uncertain or unknown"
                calc_minerals[sequence][:tantalum][:"Uncertain or Unknown"] += 1
              else
               calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tantalum_comment.to_s.strip.empty?
            calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
          end
          
          if minerals[0].tin.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tin][:"Answer not Required"] += 1
          else
            case mq.tin.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tin][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tin][:"No"] += 1
              when "uncertain or unknown"
                calc_minerals[sequence][:tin][:"Uncertain or Unknown"] += 1
              else
                calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
            end
          end
            
          if mq.tin_comment.to_s.strip.empty?
            calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tin_comment][:"Provided"] += 1
          end
          
          if minerals[0].gold.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:gold][:"Answer not Required"] += 1
          else
            case mq.gold.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:gold][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:gold][:"No"] += 1
              when "uncertain or unknown"
                calc_minerals[sequence][:gold][:"Uncertain or Unknown"] += 1
              else
                calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
            end
          end  
          
          if mq.gold_comment.to_s.strip.empty?
            calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:gold_comment][:"Provided"] += 1
          end
          
          if minerals[0].tungsten.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tungsten][:"Answer not Required"] += 1
          else
            case mq.tungsten.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tungsten][:"Yes"] += 1
              when "no"
                calc_minerals[sequence][:tungsten][:"No"] += 1
              when "uncertain or unknown"
                calc_minerals[sequence][:tungsten][:"Uncertain or Unknown"] += 1
              else
                calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tungsten_comment.to_s.strip.empty?
            calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
          end
        end
      end


      (3..3).to_a.each do |sequence|        
        if minerals[sequence]
          mq = minerals[sequence]
          row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

          if minerals[0].tantalum.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tantalum][:"Answer not Required"] += 1
          else
            case mq.tantalum.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tantalum][:"Yes"] += 1
              when "no - none"
                calc_minerals[sequence][:tantalum][:"No - None"] += 1
              when "no but > 75%"
                calc_minerals[sequence][:tantalum][:"No but > 75%"] += 1
              when "no but > 50%"
                calc_minerals[sequence][:tantalum][:"No but > 50%"] += 1
              when "no but > 25%"
                calc_minerals[sequence][:tantalum][:"No but > 25%"] += 1
              when "no but < 25%"
                calc_minerals[sequence][:tantalum][:"No but < 25%"] += 1
              else
                calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tantalum_comment.to_s.strip.empty?
            calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
          end
          
          if minerals[0].tin.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tin][:"Answer not Required"] += 1
          else
            case mq.tin.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tin][:"Yes"] += 1
              when "no - none"
                calc_minerals[sequence][:tin][:"No - None"] += 1
              when "no but > 75%"
                calc_minerals[sequence][:tin][:"No but > 75%"] += 1
              when "no but > 50%"
                calc_minerals[sequence][:tin][:"No but > 50%"] += 1
              when "no but > 25%"
                calc_minerals[sequence][:tin][:"No but > 25%"] += 1
              when "no but < 25%"
                calc_minerals[sequence][:tin][:"No but < 25%"] += 1
              else
                calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tin_comment.to_s.strip.empty?
            calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tin_comment][:"Provided"] += 1
          end
          
          if minerals[0].gold.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:gold][:"Answer not Required"] += 1
          else
            case mq.gold.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:gold][:"Yes"] += 1
              when "no - none"
                calc_minerals[sequence][:gold][:"No - None"] += 1
              when "no but > 75%"
                calc_minerals[sequence][:gold][:"No but > 75%"] += 1
              when "no but > 50%"
                calc_minerals[sequence][:gold][:"No but > 50%"] += 1
              when "no but > 25%"
                calc_minerals[sequence][:gold][:"No but > 25%"] += 1
              when "no but < 25%"
                calc_minerals[sequence][:gold][:"No but < 25%"] += 1
              else
                calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
            end
          end
          
          if mq.gold_comment.to_s.strip.empty?
            calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:gold_comment][:"Provided"] += 1
          end
          
          if minerals[0].tungsten.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tungsten][:"Answer not Required"] += 1
          else
            case mq.tungsten.to_s.strip.downcase
              when "yes"
                calc_minerals[sequence][:tungsten][:"Yes"] += 1
              when "no - none"
                calc_minerals[sequence][:tungsten][:"No - None"] += 1
              when "no but > 75%"
                calc_minerals[sequence][:tungsten][:"No but > 75%"] += 1
              when "no but > 50%"
                calc_minerals[sequence][:tungsten][:"No but > 50%"] += 1
              when "no but > 25%"
                calc_minerals[sequence][:tungsten][:"No but > 25%"] += 1
              when "no but < 25%"
                calc_minerals[sequence][:tungsten][:"No but < 25%"] += 1
              else
                calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tungsten_comment.to_s.strip.empty?
            calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
          end
          
        end
      end

      (4..4).to_a.each do |sequence|         
        if minerals[sequence]
          mq = minerals[sequence]
          row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

          if minerals[0].tantalum.to_s.strip.downcase == "no"  
            calc_minerals[sequence][:tantalum][:"Answer not Required"] += 1
          else
            case mq.tantalum.to_s.strip.downcase
              when "yes all smelters have been provided"
                calc_minerals[sequence][:tantalum][:"Yes all smelters have been provided"] += 1
              when "no"
                calc_minerals[sequence][:tantalum][:"No"] += 1
              else
                calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tantalum_comment.to_s.strip.empty?
           calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
          end
          
          if minerals[0].tin.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tin][:"Answer not Required"] += 1
          else
            case mq.tin.to_s.strip.downcase
              when "yes all smelters have been provided"
                calc_minerals[sequence][:tin][:"Yes all smelters have been provided"] += 1
              when "no"
                calc_minerals[sequence][:tin][:"No"] += 1
              else
                calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tin_comment.to_s.strip.empty?
            calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tin_comment][:"Provided"] += 1
          end
          
          if minerals[0].gold.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:gold][:"Answer not Required"] += 1
          else
            case mq.gold.to_s.strip.downcase
              when "yes all smelters have been provided"
                calc_minerals[sequence][:gold][:"Yes all smelters have been provided"] += 1
              when "no"
                calc_minerals[sequence][:gold][:"No"] += 1
              else
                calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
            end
          end
          
          if mq.gold_comment.to_s.strip.empty?
            calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:gold_comment][:"Provided"] += 1
          end
          
          if minerals[0].tungsten.to_s.strip.downcase == "no" 
            calc_minerals[sequence][:tungsten][:"Answer not Required"] += 1
          else
            case mq.tungsten.to_s.strip.downcase
              when "yes all smelters have been provided"
                calc_minerals[sequence][:tungsten][:"Yes all smelters have been provided"] += 1
              when "no"
                calc_minerals[sequence][:tungsten][:"No"] += 1
              else
                calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
            end
          end
          
          if mq.tungsten_comment.to_s.strip.empty?
            calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
          else
            calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
          end
            
        end
      end


  (5..5).to_a.each do |sequence|         
    if minerals[sequence]
      mq = minerals[sequence]
      row += [mq.tantalum, mq.tantalum_comment, mq.tin, mq.tin_comment, mq.gold, mq.gold_comment, mq.tungsten, mq.tungsten_comment]

      if minerals[0].tantalum.to_s.strip.downcase == "no" 
        calc_minerals[sequence][:tantalum][:"Answer not Required"] += 1
      else
        case mq.tantalum.to_s.strip.downcase
          when "yes"
            calc_minerals[sequence][:tantalum][:"Yes"] += 1
          when "no"
            calc_minerals[sequence][:tantalum][:"No"] += 1
          when "unknown"
            calc_minerals[sequence][:tantalum][:"Unknown"] += 1
          else
            calc_minerals[sequence][:tantalum][:"No Answer Provided"] += 1
        end
      end
      
      if mq.tantalum_comment.to_s.strip.empty?
        calc_minerals[sequence][:tantalum_comment][:"Not Provided"] += 1
      else
        calc_minerals[sequence][:tantalum_comment][:"Provided"] += 1
      end
      
      if minerals[0].tin.to_s.strip.downcase == "no" 
        calc_minerals[sequence][:tin][:"Answer not Required"] += 1
      else
        case mq.tin.to_s.strip.downcase
          when "yes"
            calc_minerals[sequence][:tin][:"Yes"] += 1
          when "no"
            calc_minerals[sequence][:tin][:"No"] += 1
          when "unknown"
            calc_minerals[sequence][:tin][:"Unknown"] += 1
          else
            calc_minerals[sequence][:tin][:"No Answer Provided"] += 1
        end
      end
      
      if mq.tin_comment.to_s.strip.empty?
      calc_minerals[sequence][:tin_comment][:"Not Provided"] += 1
      else
      calc_minerals[sequence][:tin_comment][:"Provided"] += 1
      end
      if minerals[0].gold.to_s.strip.downcase == "no" 
      calc_minerals[sequence][:gold][:"Answer not Required"] += 1
      else
      case mq.gold.to_s.strip.downcase
      when "yes"
      calc_minerals[sequence][:gold][:"Yes"] += 1
      when "no"
      calc_minerals[sequence][:gold][:"No"] += 1
      when "unknown"
      calc_minerals[sequence][:gold][:"Unknown"] += 1
      else
      calc_minerals[sequence][:gold][:"No Answer Provided"] += 1
      end
      end
      if mq.gold_comment.to_s.strip.empty?
      calc_minerals[sequence][:gold_comment][:"Not Provided"] += 1
      else
      calc_minerals[sequence][:gold_comment][:"Provided"] += 1
      end
      if minerals[0].tungsten.to_s.strip.downcase == "no" 
      calc_minerals[sequence][:tungsten][:"Answer not Required"] += 1
      else
      case mq.tungsten.to_s.strip.downcase
      when "yes"
      calc_minerals[sequence][:tungsten][:"Yes"] += 1
      when "no"
      calc_minerals[sequence][:tungsten][:"No"] += 1
      when "unknown"
      calc_minerals[sequence][:tungsten][:"Unknown"] += 1
      else
      calc_minerals[sequence][:tungsten][:"No Answer Provided"] += 1
      end
      end
      if mq.tungsten_comment.to_s.strip.empty?
      calc_minerals[sequence][:tungsten_comment][:"Not Provided"] += 1
      else
      calc_minerals[sequence][:tungsten_comment][:"Provided"] += 1
      end
      
    end
  end
# end of minerals questions


  (0..9).to_a.each do |sequence|
    if company_level[sequence]
      clq = company_level[sequence]
      row += [clq.answer, clq.comment]

      case sequence
        when 0
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 1
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 2
          case clq.answer.to_s.strip.downcase
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
          case clq.answer.to_s.strip.downcase
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
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 5
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 6
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 7
          case clq.answer.to_s.strip.downcase
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
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
          end
        when 9
          case clq.answer.to_s.strip.downcase
            when "yes"
              calc_company_level[sequence][:answer][:"Yes"] += 1
            when "no"
              calc_company_level[sequence][:answer][:"No"] += 1
            else
              calc_company_level[sequence][:answer][:"No answer provided"] += 1
           end
      end

      if clq.comment.to_s.strip.empty?
        calc_company_level[sequence][:comment][:"Not Provided"] += 1
      else
        calc_company_level[sequence][:comment][:"Provided"] += 1
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

    row += [smelter_group_tantalum[:identified].size, smelter_group_tantalum[:not_listed].size, smelter_group_tantalum[:not_yet_identified].size]
    row += [smelter_group_tin[:identified].size, smelter_group_tin[:not_listed].size, smelter_group_tin[:not_yet_identified].size]
    row += [smelter_group_gold[:identified].size, smelter_group_gold[:not_listed].size, smelter_group_gold[:not_yet_identified].size]
    row += [smelter_group_tungsten[:identified].size, smelter_group_tungsten[:not_listed].size, smelter_group_tungsten[:not_yet_identified].size]

    # Extra data
    row += [dec.created_at.to_formatted_s(:local), dec.uploaded_excel.filename, ivs.status, ivs.message.gsub(/(<li>|<\/li>)/, "")]

    rows << row
  end

   

    # Counts
    totals =  ["TOTALS",
        "%d Provided \n%d Not Provided" % [calc_company_name[:"Provided"], calc_company_name[:"Not Provided"]],
        "%d Company level \n%d Division level \n%d Product category level \n%d Product level \n%d Empty" % [calc_declaration_scope[:"Company level"], calc_declaration_scope[:"Division level"], calc_declaration_scope[:"Product category level"], calc_declaration_scope[:"Product level"], calc_declaration_scope[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_description_of_scope[:"Provided"], calc_description_of_scope[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_unique_identifier[:"Provided"], calc_company_unique_identifier[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_address[:"Provided"], calc_address[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_authorized_company_representative_name[:"Provided"], calc_authorized_company_representative_name[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_representative_title[:"Provided"], calc_representative_title[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_representative_email[:"Provided"], calc_representative_email[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_representative_phone[:"Provided"], calc_representative_phone[:"Not Provided"]],
        "%d Provided \n%d Not Provided" % [calc_completion_at[:"Provided"], calc_completion_at[:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided" % [calc_minerals[0][:tantalum][:"Yes"], calc_minerals[0][:tantalum][:"No"], calc_minerals[0][:tantalum][:"No Answer Provided"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[0][:tantalum_comment][:"Provided"], calc_minerals[0][:tantalum_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided" % [calc_minerals[0][:tin][:"Yes"], calc_minerals[0][:tin][:"No"], calc_minerals[0][:tin][:"No Answer Provided"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[0][:tin_comment][:"Provided"], calc_minerals[0][:tin_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided" % [calc_minerals[0][:gold][:"Yes"], calc_minerals[0][:gold][:"No"], calc_minerals[0][:gold][:"No Answer Provided"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[0][:gold_comment][:"Provided"], calc_minerals[0][:gold_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided" % [calc_minerals[0][:tungsten][:"Yes"], calc_minerals[0][:tungsten][:"No"], calc_minerals[0][:tungsten][:"No Answer Provided"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[0][:tungsten_comment][:"Provided"], calc_minerals[0][:tungsten_comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[1][:tantalum][:"Yes"], calc_minerals[1][:tantalum][:"No"], calc_minerals[1][:tantalum][:"No Answer Provided"], calc_minerals[1][:tantalum][:"Answer not Required"], calc_minerals[1][:tantalum][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[1][:tantalum_comment][:"Provided"], calc_minerals[1][:tantalum_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[1][:tin][:"Yes"], calc_minerals[1][:tin][:"No"], calc_minerals[1][:tin][:"No Answer Provided"], calc_minerals[1][:tin][:"Answer not Required"], calc_minerals[1][:tin][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[1][:tin_comment][:"Provided"], calc_minerals[1][:tin_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[1][:gold][:"Yes"], calc_minerals[1][:gold][:"No"], calc_minerals[1][:gold][:"No Answer Provided"], calc_minerals[1][:gold][:"Answer not Required"], calc_minerals[1][:gold][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[1][:gold_comment][:"Provided"], calc_minerals[1][:gold_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[1][:tungsten][:"Yes"], calc_minerals[1][:tungsten][:"No"], calc_minerals[1][:tungsten][:"No Answer Provided"], calc_minerals[1][:tungsten][:"Answer not Required"], calc_minerals[1][:tungsten][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[1][:tungsten_comment][:"Provided"], calc_minerals[1][:tungsten_comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[2][:tantalum][:"Yes"], calc_minerals[2][:tantalum][:"No"], calc_minerals[2][:tantalum][:"No Answer Provided"], calc_minerals[2][:tantalum][:"Answer not Required"], calc_minerals[2][:tantalum][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[2][:tantalum_comment][:"Provided"], calc_minerals[2][:tantalum_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[2][:tin][:"Yes"], calc_minerals[2][:tin][:"No"], calc_minerals[2][:tin][:"No Answer Provided"], calc_minerals[2][:tin][:"Answer not Required"], calc_minerals[2][:tin][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[2][:tin_comment][:"Provided"], calc_minerals[2][:tin_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[2][:gold][:"Yes"], calc_minerals[2][:gold][:"No"], calc_minerals[2][:gold][:"No Answer Provided"], calc_minerals[2][:gold][:"Answer not Required"], calc_minerals[2][:gold][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[2][:gold_comment][:"Provided"], calc_minerals[2][:gold_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Uncertain or Unknown" % [calc_minerals[2][:tungsten][:"Yes"], calc_minerals[2][:tungsten][:"No"], calc_minerals[2][:tungsten][:"No Answer Provided"], calc_minerals[2][:tungsten][:"Answer not Required"], calc_minerals[2][:tungsten][:"Uncertain or Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[2][:tungsten_comment][:"Provided"], calc_minerals[2][:tungsten_comment][:"Not Provided"]],

        "%d Yes \n%d No but > 75%% \n%d No but > 50%% \n%d No but > 25%% \n%d No but < 25%% \n%d No - None \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[3][:tantalum][:"Yes"], calc_minerals[3][:tantalum][:"No but > 75%"], calc_minerals[3][:tantalum][:"No but > 50%"],calc_minerals[3][:tantalum][:"No but > 25%"], calc_minerals[3][:tantalum][:"No but < 25%"], calc_minerals[3][:tantalum][:"No - None"],  calc_minerals[3][:tantalum][:"No Answer Provided"], calc_minerals[3][:tantalum][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[3][:tantalum_comment][:"Provided"], calc_minerals[3][:tantalum_comment][:"Not Provided"]],
        "%d Yes \n%d No but > 75%% \n%d No but > 50%% \n%d No but > 25%% \n%d No but < 25%% \n%d No - None \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[3][:tin][:"Yes"],  calc_minerals[3][:tin][:"No but > 75%"], calc_minerals[3][:tin][:"No but > 50%"],calc_minerals[3][:tin][:"No but > 25%"], calc_minerals[3][:tin][:"No but < 25%"], calc_minerals[3][:tin][:"No - None"], calc_minerals[3][:tin][:"No Answer Provided"], calc_minerals[3][:tin][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[3][:tin_comment][:"Provided"], calc_minerals[3][:tin_comment][:"Not Provided"]],
        "%d Yes \n%d No but > 75%% \n%d No but > 50%% \n%d No but > 25%% \n%d No but < 25%% \n%d No - None \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[3][:gold][:"Yes"],  calc_minerals[3][:gold][:"No but > 75%"], calc_minerals[3][:gold][:"No but > 50%"],calc_minerals[3][:gold][:"No but > 25%"], calc_minerals[3][:gold][:"No but < 25%"], calc_minerals[3][:gold][:"No - None"], calc_minerals[3][:gold][:"No Answer Provided"], calc_minerals[3][:gold][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[3][:gold_comment][:"Provided"], calc_minerals[3][:gold_comment][:"Not Provided"]],
        "%d Yes \n%d No but > 75%% \n%d No but > 50%% \n%d No but > 25%% \n%d No but < 25%% \n%d No - None \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[3][:tungsten][:"Yes"],  calc_minerals[3][:tungsten][:"No but > 75%"], calc_minerals[3][:tungsten][:"No but > 50%"],calc_minerals[3][:tungsten][:"No but > 25%"], calc_minerals[3][:tungsten][:"No but < 25%"], calc_minerals[3][:tungsten][:"No - None"], calc_minerals[3][:tungsten][:"No Answer Provided"], calc_minerals[3][:tungsten][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[3][:tungsten_comment][:"Provided"], calc_minerals[3][:tungsten_comment][:"Not Provided"]],

        "%d Yes all smelters have been provided \n%d No \n None \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[4][:tantalum][:"Yes all smelters have been provided"], calc_minerals[4][:tantalum][:"No"], calc_minerals[4][:tantalum][:"No Answer Provided"], calc_minerals[4][:tantalum][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[4][:tantalum_comment][:"Provided"], calc_minerals[4][:tantalum_comment][:"Not Provided"]],
        "%d Yes all smelters have been provided \n%d No \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[4][:tin][:"Yes all smelters have been provided"], calc_minerals[4][:tin][:"No"], calc_minerals[4][:tin][:"No Answer Provided"], calc_minerals[4][:tin][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[4][:tin_comment][:"Provided"], calc_minerals[4][:tin_comment][:"Not Provided"]],
        "%d Yes all smelters have been provided \n%d No \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[4][:gold][:"Yes all smelters have been provided"], calc_minerals[4][:gold][:"No"], calc_minerals[4][:gold][:"No Answer Provided"], calc_minerals[4][:gold][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[4][:gold_comment][:"Provided"], calc_minerals[4][:gold_comment][:"Not Provided"]],
        "%d Yes all smelters have been provided \n%d No \n%d No Answer Provided \n%d Answer not Required" % [calc_minerals[4][:tungsten][:"Yes all smelters have been provided"], calc_minerals[4][:tungsten][:"No"], calc_minerals[4][:tungsten][:"No Answer Provided"], calc_minerals[4][:tungsten][:"Answer not Required"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[4][:tungsten_comment][:"Provided"], calc_minerals[4][:tungsten_comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Unknown" % [calc_minerals[5][:tantalum][:"Yes"], calc_minerals[5][:tantalum][:"No"], calc_minerals[5][:tantalum][:"No Answer Provided"], calc_minerals[5][:tantalum][:"Answer not Required"], calc_minerals[5][:tantalum][:"Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[5][:tantalum_comment][:"Provided"], calc_minerals[5][:tantalum_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Unknown" % [calc_minerals[5][:tin][:"Yes"], calc_minerals[5][:tin][:"No"], calc_minerals[5][:tin][:"No Answer Provided"], calc_minerals[5][:tin][:"Answer not Required"], calc_minerals[5][:tin][:"Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[5][:tin_comment][:"Provided"], calc_minerals[5][:tin_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Unknown" % [calc_minerals[5][:gold][:"Yes"], calc_minerals[5][:gold][:"No"], calc_minerals[5][:gold][:"No Answer Provided"], calc_minerals[5][:gold][:"Answer not Required"], calc_minerals[5][:gold][:"Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[5][:gold_comment][:"Provided"], calc_minerals[5][:gold_comment][:"Not Provided"]],
        "%d Yes \n%d No \n%d No Answer Provided \n%d Answer not Required \n%d Unknown" % [calc_minerals[5][:tungsten][:"Yes"], calc_minerals[5][:tungsten][:"No"], calc_minerals[5][:tungsten][:"No Answer Provided"], calc_minerals[5][:tungsten][:"Answer not Required"], calc_minerals[5][:tungsten][:"Unknown"]],
        "%d Provided \n%d Not Provided" % [calc_minerals[5][:tungsten_comment][:"Provided"], calc_minerals[5][:tungsten_comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[0][:answer][:"Yes"], calc_company_level[0][:answer][:"No"], calc_company_level[0][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[0][:comment][:"Provided"], calc_company_level[0][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[1][:answer][:"Yes"], calc_company_level[1][:answer][:"No"], calc_company_level[1][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[1][:comment][:"Provided"], calc_company_level[1][:comment][:"Not Provided"]],

        "%d Yes \n%d Yes included in standard contract language \n%d No \n%d No answer provided" % [calc_company_level[2][:answer][:"Yes"], calc_company_level[2][:answer][:"Yes included in standard contract language"], calc_company_level[2][:answer][:"No"], calc_company_level[2][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[2][:comment][:"Provided"], calc_company_level[2][:comment][:"Not Provided"]],

        "%d Yes \n%d Planned once lists become available \n%d No \n%d No answer provided" % 
        [calc_company_level[3][:answer][:"Yes"], calc_company_level[3][:answer][:"Planned once lists become available"], calc_company_level[3][:answer][:"No"], calc_company_level[3][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[3][:comment][:"Provided"], calc_company_level[3][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[4][:answer][:"Yes"], calc_company_level[4][:answer][:"No"], calc_company_level[4][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[4][:comment][:"Provided"], calc_company_level[4][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[5][:answer][:"Yes"], calc_company_level[5][:answer][:"No"], calc_company_level[5][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[5][:comment][:"Provided"], calc_company_level[5][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[6][:answer][:"Yes"], calc_company_level[6][:answer][:"No"], calc_company_level[6][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[6][:comment][:"Provided"], calc_company_level[6][:comment][:"Not Provided"]],

        "%d Yes (3rd party audit) \n%d Yes (documentation review only) \n%d Yes (internal audit) \n%d Yes (all methods apply) \n%d No \n%d No answer provided" %
        [calc_company_level[7][:answer][:"Yes (3rd party audit)"],
        calc_company_level[7][:answer][:"Yes (documentation review only)"],
        calc_company_level[7][:answer][:"Yes (internal audit)"],
        calc_company_level[7][:answer][:"Yes (all methods apply)"],
        calc_company_level[7][:answer][:"No"],
        calc_company_level[7][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[7][:comment][:"Provided"], calc_company_level[7][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[8][:answer][:"Yes"], calc_company_level[8][:answer][:"No"], calc_company_level[8][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[8][:comment][:"Provided"], calc_company_level[8][:comment][:"Not Provided"]],

        "%d Yes \n%d No \n%d No answer provided" % [calc_company_level[9][:answer][:"Yes"], calc_company_level[9][:answer][:"No"], calc_company_level[9][:answer][:"No answer provided"]],
        "%d Provided \n%d Not Provided" % [calc_company_level[9][:comment][:"Provided"], calc_company_level[9][:comment][:"Not Provided"]]
 
        ]

        # get data rows sorted alphabetically by company name, declaration of scope, and description of scope, and eventually product list
	  
    
       sorted_rows = []
       rows_running_count = 0
       rows.sort_by { |e| [e[0].to_s, e[1].to_s, e[2].to_s, e[3].to_s ] }.each do |r|
	    rows_running_count += 1
	    sorted_rows << [rows_running_count] + r
        end	    
          

        # Create spreadsheet  
    spreadsheet = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Aggregated Declarations") do |sheet|
        # Style                                                      
        header_style = nil
        row_style    = nil
	totals_style = nil
        first_row_style = nil
	report_title_style = nil
	report_date_time_style = nil
	date_style = nil
	time_style = nil
	
        
        p.workbook.styles do |style|
          header_style = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :left }
          row_style    = style.add_style :b => false, :sz => 9,  :alignment => { :wrap_text => true, :horizontal => :left }
	  totals_style = style.add_style :b => true, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :left } ## fadd color 
          first_row_style             = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :center } 
	  report_title_style         = style.add_style :bg_color => "FFFF0000",  :fg_color=>"#FF000000", :border=>Axlsx::STYLE_THIN_BORDER, :alignment=>{:horizontal => :center}
          report_date_time_style = style.add_style :num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS,  :border=>Axlsx::STYLE_THIN_BORDER
	  date_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'YYYY-MM-DD', :alignment => { :wrap_text => true, :horizontal => :center } 
	  time_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'hh:mm:ss', :alignment => { :wrap_text => true, :horizontal => :center } 
        end
        
        # GSP Logo image
        sheet.add_image(:image_src => File.expand_path("../../public/images/logo.jpg", File.dirname(__FILE__)), :noSelect => true, :noMove => true, :hyperlink => "http://www.greenstatuspro.com") do |image|
          image.width  = 4
          image.height = 3
          image.hyperlink.tooltip = "Green Status Pro"
          image.start_at 0, 0
          image.end_at 2, 1
        end

	first_row = ['', '', '', "AGGREGATED \n DECLARATIONS \n REPORT \n for: ", "Date:", "Time:", "User:"]
        sheet.add_row( first_row, :style => [nil, nil, nil, first_row_style, first_row_style, first_row_style, first_row_style], :widths => [7, 25, 25, 25, 25, 25, 25, 25]).height = 86.0
        sheet.merge_cells "A1:B1"
	
        second_row = ['', '', '', current_user.organization.full_name, Date.today, Time.now, current_user.eponym] 
        sheet.add_row( second_row, :style => [nil, nil, nil, first_row_style, date_style, time_style, first_row_style] , :widths => [7, 25, 25, 25, 25, 25, 25, 25]).height = 22.0

        # Add header row
        sheet.add_row(header, :style => header_style, :widths => [7, 25, 25, 25, 25, 25, 25, 25, 25, 20, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 300]).height = 48.0
        
        # Append data rows
        sorted_rows.each do |r|
          sheet.add_row(r, :style => row_style,  :widths => [7, 25, 25, 25, 25, 25, 25, 25, 25, 20, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 300])
	   #check rows can use :ignore and :auto)   row <<  ([''] * 13) + row_second_part
	end
  
	# Add totals row
	sheet.add_row(totals, :style => totals_style, :widths => [7, 25, 25, 25, 25, 25, 25, 25, 25, 20, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 17, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 300]).height =  105.0
	
        # Freeze pane over data rows
        sheet.sheet_view.pane do |pane|
          pane.top_left_cell = "A4"
          pane.state = :frozen_split
          pane.y_split = 3
          pane.x_split = 0
          pane.active_pane = :bottom_right
        end

        
      end
    end

     send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_aggregated_declarations_report.gsp.xlsx"), :type => 'application/excel'
    
  end

# TODO ISSUES TO DISCUSS
# how are we getting the latest spread sheet from each extended company name/scope/product list?
# when we ad review id will be able to have this same report work as either a batch-only report by entering a parameter of batch and the batch id or a "complete" report by entering "review" and review_id as parameters
# IN DECLARATION PROCESSING LOGIC need to check for comments in company-level questions B-1-YES-THEN URL, F-5-NO-THEN SOME COMMENT,I-8_YES-THEN SOME COMMENTS 
  

  def eicc_detailed_smelter_report
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first

    
      header = [
	      "   #   ",
	      "Supplier Company Name",
              "Metal", 
	      "Smelter Reference List", 
              "Standard Smelter Names", 
              "Smelter Facility Location \n Country", 
              "Smelter ID", 
              "Smelter Facility Location \n Street Address", 
              "Smelter Facility Location \n City", 
              "Smelter Facility Location \n State Province", 
              "Smelter Facility \n Contact Name", 
              "Smelter Facility \n Contact Email", 
              "Proposed next steps, if applicable", 
              "Name of Mines or if recycled or scrap sourced, state recycled or scrap", 
              "Location of Mines or if recycled or scrap sourced, state recycled or scrap", 
              "Comments",
	      "File Name",
	      "Date File Ingested into GSP",
              "Validation Status",
	      "Supplier Company Name",
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
              "Question 1 Comments - Tungsten"
              ]
	      
	 rows = []     
      @batch.individual_validation_statuses.each do |ivs|
        next if ivs.declaration.nil?

        dec = ivs.declaration
        question_1 = dec.mineral_questions.sort_by(&:sequence).first

        row_middle_part = [
	                  dec.uploaded_excel.filename,
			  dec.created_at.to_formatted_s(:local),
                          ivs.status,
			  dec.company_name,
                          dec.declaration_scope,
                          dec.description_of_scope,
                          dec.company_unique_identifier,
                          dec.address,
                          dec.authorized_company_representative_name,
                          dec.representative_title,
                          dec.representative_email,
                          dec.representative_phone]
			  
			   completed_at_date = 0
                           if dec.completion_at.nil? then completed_at_date = "No Date Given" else completed_at_date = dec.completion_at.strftime('%B %d, %Y') end    # dec.completion_at.strftime('%d, %B, %Y')(:local)]
        
	row_second_part  = row_middle_part + [completed_at_date, 
                          
                          question_1.tantalum,
                          question_1.tantalum_comment,
                          question_1.tin,
                          question_1.tin_comment,
                          question_1.gold,
                          question_1.gold_comment,
                          question_1.tungsten,
                          question_1.tungsten_comment
                          ]

        if dec.smelter_list.nil?
          row <<  ([''] * 13) + row_second_part
        else
          dec.smelter_list.each do |smelter|
            row_first_part = [
                  	       dec.company_name, 
			       smelter.metal,
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
            rows << row       
          end
        end

      end
    
    
       
 #   rows = rows.sort_by { |e| [ e[1].to_s,  e[20].to_s, e[21].to_s, e[2].to_s, e[3].to_s, e[4].to_s, e[5].to_s, e[6].to_s ] }
    
    sorted_rows = []
    rows_running_count = 0
    rows.sort_by { |e| [ e[0].to_s, e[19].to_s, e[20].to_s, e[21].to_s, e[1].to_s, e[2].to_s, e[3].to_s, e[4].to_s ] }.each do |r|
            rows_running_count += 1
	    sorted_rows << [rows_running_count] + r
      end	    





    
    # Create spreadsheet
    spreadsheet = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "GSP Smelter by Supplier List") do |sheet|
        # Style
        header_style = nil
        row_style    = nil
        first_row_style = nil
	report_title_style = nil
	report_date_time_style = nil
	date_style = nil
	time_style = nil
        
        p.workbook.styles do |style|
          header_style               = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :left }
          row_style                   = style.add_style :b => false, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :left }
          first_row_style             = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :center } 
	  report_title_style         = style.add_style :bg_color => "FFFF0000",  :fg_color=>"#FF000000", :border=>Axlsx::STYLE_THIN_BORDER, :alignment=>{:horizontal => :center}
          report_date_time_style = style.add_style :num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS,  :border=>Axlsx::STYLE_THIN_BORDER
	  date_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'YYYY-MM-DD', :alignment => { :wrap_text => true, :horizontal => :center } 
	  time_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'hh:mm:ss', :alignment => { :wrap_text => true, :horizontal => :center } 
        end
        
        # GSP Logo image
        sheet.add_image(:image_src => File.expand_path("../../public/images/logo.jpg", File.dirname(__FILE__)), :noSelect => true, :noMove => true, :hyperlink => "http://www.greenstatuspro.com") do |image|
          image.width  = 4
          image.height = 3
          image.hyperlink.tooltip = "Green Status Pro"
          image.start_at 0, 0
          image.end_at 2, 1
        end
 	
	first_row = ['', '', '', "SMELTER \n by SUPPLIER \n LIST \n for: ", "Date:", "Time:", 'User:', '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( first_row, :style => [nil, nil, nil, first_row_style, first_row_style, first_row_style, first_row_style, nil, nil, nil] , :widths => [7, 25, 8, 30, 20, 25, 15, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20]).height = 86.0
        sheet.merge_cells "A1:B1"
        
	second_row = ['', '', '', current_user.organization.full_name, Date.today, Time.now, current_user.eponym, '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( second_row, :style => [nil, nil, nil, first_row_style, date_style, time_style, first_row_style, nil, nil, nil] , :widths => [7, 25, 8, 30, 20, 25, 15, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20]).height = 22.0

        
        # Add header row
        sheet.add_row(header, :style => header_style, :widths => [7, 25, 8, 30, 20, 25, 15, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20]).height = 48.0
        
        # Append data rows
        sorted_rows.each do |r|
          sheet.add_row(r, :style => row_style, :widths => [7, 25, 8, 30, 20, 25, 15, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 30, 30, 30, 30, 30, 30, 20, 20, 20, 20, 20, 20, 20, 20])
        end
        
        # Freeze pane over data rows
        sheet.sheet_view.pane do |pane|
          pane.top_left_cell = "A4"
          pane.state = :frozen_split
          pane.y_split = 3
          pane.x_split = 0
          pane.active_pane = :bottom_right
        end

        
      end
    end

     send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_smelter_by_supplier_list.gsp.xlsx"), :type => 'application/excel'
     
  end
  
  
  #============================================================
  # EICC Consolidated Smelter Report
  #    
  
 
  def eicc_consolidated_smelter_list
    @batch = Eicc::BatchValidationStatus.where(:id => params[:id], :user_id => current_user.id).first
    
    @latest_declarations = []
    
    # Only select the latest declaration submitted by "company_name" ### FIX!!!  sort and prev_company need to be expressed as EXTENDED COMPANY NAME (company_name,declaration_of_scope,description_of_scope,product_list)
    prev_company = nil
    Eicc::IndividualValidationStatus.where(:parent_id => @batch.id).order("company_name ASC, created_at DESC").each do |ivs|
      next if prev_company == ivs.company_name
      next if ivs.declaration.nil?
      @latest_declarations << ivs.declaration
      prev_company = ivs.company_name
    end
    
    # Group declarations by smelter
    declarations_by_smelter = {}
    
    @latest_declarations.each do |declaration|
      declaration.smelter_list.each do |smelter|
        smelter_key = [smelter.metal, smelter.smelter_reference_list, smelter.standard_smelter_name, smelter.facility_location_country, smelter.smelter_id,
                       smelter.facility_location_street_address, smelter.facility_location_city, smelter.facility_location_province, smelter.facility_contact_name,
                       smelter.facility_contact_email, smelter.proposed_next_steps, smelter.mineral_source, smelter.mineral_source_location, smelter.comment]
        declarations_by_smelter[smelter_key] = [] if declarations_by_smelter[smelter_key].nil?
        declarations_by_smelter[smelter_key] << declaration
      end
    end
    
    # Gather all the required data and sort
    header = ["   #   ", 
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
              "Source EICC Report(s)",
	      "Number of Source EICC Reports"]

    rows_second_part = []
    
    declarations_by_smelter.each do |smelter_key, declarations|
            rows_second_part <<  smelter_key + [declarations.collect { |dec| dec.uploaded_excel.filename }.uniq.join(', ')]  + [declarations.uniq.count]  # rows << [rows_running_count] + smelter_key + [declarations.collect { |dec| dec.uploaded_excel.filename }.uniq.join(', ')]  + [declarations.uniq.count] 
    end
    
    total_gold_smelters = 0
    total_gold_smelters_not_yet_identified = 0
    total_gold_smelters_not_listed = 0
    
    total_tantalum_smelters = 0
    total_tantalum_smelters_not_yet_identified = 0
    total_tantalum_smelters_not_listed = 0
    
    total_tin_smelters = 0
    total_tin_smelters_not_yet_identified = 0
    total_tin_smelters_not_listed = 0
    
    total_tungsten_smelters = 0
    total_tungsten_smelters_not_yet_identified = 0
    total_tungsten_smelters_not_listed = 0
 
    total_unknown_metal_smelters = 0
    total_unknown_metal_smelters_not_yet_identified = 0
    total_unknown_metal_smelters_not_listed = 0

    total_smelters_not_identified = 0
    total_smelters_not_listed = 0
    
    highlight_red     = false
    highlight_yellow = false
    highlight_green  = false
    
    prev_smelter_row = [
       			       "0 - metal", 
                               "1 - smelter_reference_list", 
                               "2 - standard_smelter_name", 
                               "3 - facility_location_country", 
                               "4 - smelter_id", 
                               "5 - facility_location_street_address", 
                               "6 - facility_location_city", 
                               "7 - facility_location_province", 
                               "8 - facility_contact_name", 
                               "9 - facility_contact_email", 
                               "10 - proposed_next_steps", 
                               "11 - mineral_source", 
                               "12 - mineral_source_location", 
                               "13 - comment"]

    this_smelter_row = []
    
        
    rows = []
    rows_running_count = 0
    rows_second_part = rows_second_part.sort_by { |e| [ e[0].to_s, e[1].to_s, e[2].to_s, e[3].to_s] } 
    rows_second_part.each do |r2|
	    
	    rows_running_count += 1
	    this_smelter_row = r2
	      case r2[0].to_s.strip.downcase
		      when "gold"
		          total_gold_smelters += 1
			  if r2[1].to_s.strip.downcase == "smelter not listed" then total_gold_smelters_not_listed += 1 end
			  if r2[1].to_s.strip.downcase == "smelter not yet identified" then total_gold_smelters_not_yet_identified += 1 end
		       when "tantalum"
		          total_tantalum_smelters += 1
			  if r2[1].to_s.strip.downcase == "smelter not listed" then total_tantalum_smelters_not_listed += 1 end
			  if r2[1].to_s.strip.downcase == "smelter not yet identified" then total_tantalum_smelters_not_yet_identified += 1 end
		       when "tin"
			  total_tin_smelters += 1
			  if r2[1].to_s.strip.downcase == "smelter not listed" then total_tin_smelters_not_listed += 1 end
			  if r2[1].to_s.strip.downcase == "smelter not yet identified" then total_tin_smelters_not_yet_identified += 1 end
		       when "tungsten"
			  total_tungsten_smelters +=1
			  if r2[1].to_s.strip.downcase == "smelter not listed" then total_tungsten_smelters_not_listed += 1 end
			  if r2[1].to_s.strip.downcase == "smelter not yet identified" then total_tungsten_smelters_not_yet_identified += 1 end
		       else
			  total_unknown_metal_smelters +=1
			  if r2[1].to_s.strip.downcase == "smelter not listed" then total_unknown_metal_smelters_not_listed += 1 end
			  if r2[1].to_s.strip.downcase == "smelter not yet identified" then total_unknown_metal_smelters_not_yet_identified += 1 end	  
	      end
	    rows << [rows_running_count] + r2
	    prev_smelter_row = r2
    end	    
   
    
    # Create spreadsheet
    spreadsheet = Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "Consolidated Smelters") do |sheet|
        # Style
        header_style = nil
        row_style    = nil
        first_row_style = nil
	report_title_style = nil
	report_date_time_style = nil
	date_style = nil
	time_style = nil
	
	
        p.workbook.styles do |style|
          first_row_style             = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :center } 
	  header_style               = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :left } 
          row_style                   = style.add_style :b => false, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :left }  # added alignment = left
	  report_title_style         = style.add_style :bg_color => "FFFF0000",  :fg_color=>"#FF000000", :border=>Axlsx::STYLE_THIN_BORDER, :alignment=>{:horizontal => :center}
          report_date_time_style = style.add_style :num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS,  :border=>Axlsx::STYLE_THIN_BORDER
	  date_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'YYYY-MM-DD', :alignment => { :wrap_text => true, :horizontal => :center } 
	  time_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'hh:mm:ss', :alignment => { :wrap_text => true, :horizontal => :center } 
        end
        
        # GSP Logo image
        sheet.add_image(:image_src => File.expand_path("../../public/images/logo.jpg", File.dirname(__FILE__)), :noSelect => true, :noMove => true, :hyperlink => "http://www.greenstatuspro.com") do |image|
          image.width  = 4
          image.height = 3
          image.hyperlink.tooltip = "Green Status Pro"
          image.start_at 0, 0
          image.end_at 2, 1
	end
	
	first_row = ['', '', '', "CONSOLIDATED \n SMELTER \n REPORT \n for: ", "Date:", "Time:", 'User:', '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( first_row, :style => [nil, nil, nil, first_row_style, first_row_style, first_row_style, first_row_style, nil, nil, nil] , :widths => [7, 18, 40, 40, 20, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35]).height = 86.0
        sheet.merge_cells "A1:B1"
        
	second_row = ['', '', '', current_user.organization.full_name, Date.today, Time.now, current_user.eponym, '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( second_row, :style => [nil, nil, nil, first_row_style, date_style, time_style, first_row_style, nil, nil, nil] , :widths => [7, 18, 40, 40, 20, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35]).height = 22.0

        # Add header row
        sheet.add_row(header, :style => header_style , :widths => [7, 18, 40, 40, 20, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35] ).height = 48.0
           
        # Append data rows
        rows.each do |r|
           sheet.add_row(r, :style => row_style , :widths => [7, 18, 40, 40, 20, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35] )
	  # sheet.add_row( r, :style => [report_title_style, row_style, row_style, row_style,  row_style, row_style, row_style, row_style, row_style, row_style, row_style, row_style, row_style, row_style, row_style, row_style, report_title_style])
	  # here is where we would have to do cell formatting for red or yellow warning backgrounds
        end
        
        # Freeze pane over data rows
        sheet.sheet_view.pane do |pane|
          pane.top_left_cell = "A4"
          pane.state = :frozen_split
          pane.y_split = 3
          pane.x_split = 0
          pane.active_pane = :bottom_right
        end
        
      end
 
# add second worksheet
      p.workbook.add_worksheet(:name => "Consolidated Smelter Analytics") do |sheet|
        header_style = nil
        row_style    = nil
        first_row_style = nil
	report_title_style = nil
	report_date_time_style = nil
	date_style = nil
	time_style = nil
	align_right_cell_style = nil
	align_left_cell_style  = nil
	
	
        p.workbook.styles do |style|
          first_row_style             = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :center } 
	  header_style               = style.add_style :b => true, :sz => 10, :alignment => { :wrap_text => true, :horizontal => :left } 
          row_style                   = style.add_style :b => false, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :left }  
	  report_title_style         = style.add_style :bg_color => "FFFF0000",  :fg_color=>"#FF000000", :border=>Axlsx::STYLE_THIN_BORDER, :alignment=>{:horizontal => :center}
          report_date_time_style = style.add_style :num_fmt => Axlsx::NUM_FMT_YYYYMMDDHHMMSS,  :border=>Axlsx::STYLE_THIN_BORDER
	  date_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'YYYY-MM-DD', :alignment => { :wrap_text => true, :horizontal => :center } 
	  time_style                  = style.add_style :b => true,  :sz => 10, :format_code => 'hh:mm:ss', :alignment => { :wrap_text => true, :horizontal => :center } 
          align_right_cell_style    = style.add_style :b => false, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :right }  
          align_left_cell_style      = style.add_style :b => false, :sz => 9, :alignment => { :wrap_text => true, :horizontal => :left }  
        end
        
        # GSP Logo image
        sheet.add_image(:image_src => File.expand_path("../../public/images/logo.jpg", File.dirname(__FILE__)), :noSelect => true, :noMove => true, :hyperlink => "http://www.greenstatuspro.com") do |image|
          image.width  = 4
          image.height = 3
          image.hyperlink.tooltip = "Green Status Pro"
          image.start_at 0, 0
          image.end_at 1, 1
	end
	
	first_row = ['', '',  "CONSOLIDATED \n SMELTER \n ANALYTICS \n for: ", "Date:", "Time:", 'User:', '', '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( first_row, :style => [nil, nil, first_row_style, first_row_style, first_row_style, first_row_style, nil, nil, nil, nil] , :widths => [30, 10, 25, 15, 15, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35]).height = 86.0
        # sheet.merge_cells "A1:B1"
        
	second_row = ['', '',  current_user.organization.full_name, Date.today, Time.now, current_user.eponym, '', '', '', '', '', '', '', '', '', '', ''] 
        sheet.add_row( second_row, :style => [nil, nil, first_row_style, date_style, time_style, first_row_style, nil, nil, nil, nil] , :widths => [30, 10, 25, 15, 15, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35]).height = 22.0

        # Add header row
	sheet.add_row(["Item", "Value"], :style => header_style , :widths => [30, 10] ).height = 48.0
        
        # Append analytic data rows
           
 	  
           sheet.add_row( ["Total entries - Gold",  total_gold_smelters], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	  
           sheet.add_row( ["Total entries - Tin",  total_tin_smelters], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	  
           sheet.add_row( ["Total entries - Tantalum", total_tantalum_smelters], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	  
	   sheet.add_row( ["Total entries - Tungsten",  total_tungsten_smelters], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	   
	   if total_unknown_metal_smelters == 0 then
		               sheet.add_row( ["   " , "________" ], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
			       else
			       sheet.add_row( ["Total entries - Unknown Metals",  total_unknown_metal_smelters], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 22.0	       
		               end 
		       
           
	   total_all_smelters = total_gold_smelters + total_tantalum_smelters + total_tin_smelters + total_tungsten_smelters + total_unknown_metal_smelters
	   # check that total_all_smelters is equal to rows_running_count
	   sheet.add_row( ["Total entries - all metals",  total_all_smelters ], :style => [align_left_cell_style, align_right_cell_style] , :widths => [30, 10] ).height = 15.0

           sheet.add_row( ["   " , " " ], :style => row_style , :widths =>  [30, 10] ).height = 15.0

           total_smelters_not_listed = total_gold_smelters_not_listed + total_tantalum_smelters_not_listed + total_tin_smelters_not_listed + total_tungsten_smelters_not_listed + total_unknown_metal_smelters_not_listed
	   sheet.add_row( ["Total entries - Smelter Not Listed",  total_smelters_not_listed], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	  
           total_smelters_not_yet_identified = total_gold_smelters_not_yet_identified + total_tantalum_smelters_not_yet_identified + total_tin_smelters_not_yet_identified + total_tungsten_smelters_not_yet_identified + total_unknown_metal_smelters_not_yet_identified
           sheet.add_row( ["Total entries - Smelter not yet Identifed",  total_smelters_not_yet_identified], :style => [align_left_cell_style, align_right_cell_style] , :widths =>  [30, 10] ).height = 15.0
	  
	  # r8 = [Top 10 Smelters Listings: (from Smelter ID column F on Smelter list worksheet", 
           sheet.add_row( ["Top 10 Smelter Listings",  'TBD - in process'], :style => row_style , :widths =>  [30, 10] ).height = 50.0
	  
	  # r9 = Top 10 Countries: (from Column E)
           sheet.add_row( ["Total 10 Countries",  'TBD - in process'], :style => row_style , :widths => [30, 10, 25, 15, 15, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35] ).height = 50.0
	  
	  # r10 = [x.	Top 10 Suppliers Reporting Smelters (Supplier Name, Declaration Worksheet, D8): # (Count of Entries on Smelter List Worksheet, Column B, sorted by highest number)
           sheet.add_row( ["Top 10 Suppliers reporting Smelters",  'TBD - in process'], :style => row_style , :widths => [30, 10, 25, 15, 15, 10, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35, 35] ).height = 50.0
	  
          
        # Freeze pane over data rows
        sheet.sheet_view.pane do |pane|
          pane.top_left_cell = "A4"
          pane.state = :frozen_split
          pane.y_split = 3
          pane.x_split = 0
          pane.active_pane = :bottom_right
        end

      end
 
    end
    
    send_data spreadsheet.to_stream(false).read, :filename => report_filename("eicc_consolidated_smelter_report.gsp.xlsx"), :type => 'application/excel'
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
