class Cfsi::Declaration::V3Validator < ActiveModel::Validator
  attr_accessor :declaration
  attr_reader   :messages
  attr_reader   :basic, :minerals, :company_level, :smelters_list, :standard_smelter_names, :products_list
  attr_reader   :has_tantalum, :has_tin, :has_gold, :has_tungsten
private
  attr_writer :messages
  attr_writer :basic, :minerals, :company_level, :smelters_list, :standard_smelter_names, :products_list
  attr_writer :has_tantalum, :has_tin, :has_gold, :has_tungsten
public

  def initialize(args = {:declaration => nil})
    super
    @declaration = args[:declaration]
    @has_tantalum = @has_tin = @has_gold = @has_tungsten = false
  end

  def load_messages
    @messages = YAML::load_file(File.join('config', 'cfsi', @declaration.version, 'messages.en.yml'))["en"]
    @basic = @declaration.errors[:base]
    @minerals = @declaration.errors[:minerals]
    @company_level = @declaration.errors[:company_level]
    @smelters_list = @declaration.errors[:smelters_list]
    @standard_smelter_names = @declaration.errors[:standard_smelter_names]
    @products_list = @declaration.errors[:products_list]
  end

  def validate(record)
    return unless record.version.split('.').first == '3'
    @declaration = record
    load_messages
    validate_basic_fields
    if is_in_scope?
      validate_minerals_fields
      validate_company_level_fields
      cross_validate_minerals_and_smelters
      validate_mineral_smelters
      cross_validate_basic_and_products
    end
  end

  def is_in_scope?
    if @declaration.minerals_questions.size < 7
      @minerals << @messages[:declaration][:no_presence][:mineral_questions]
    elsif @declaration.minerals_questions.size > 0
      %w(tantalum tin gold tungsten).each do |mineral|
        has_mineral = (@declaration.minerals_questions[0].send(mineral).to_s.downcase == 'yes' || @declaration.minerals_questions[1].send(mineral).to_s.downcase == 'yes')
        eval("@has_#{mineral} = has_mineral")
      end
    end
    @has_tantalum || @has_tin || @has_gold || @has_tungsten
  end

  def validate_basic_fields
    @basic << @messages[:declaration][:no_presence][:company_name] if @declaration.company_name.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:declaration_scope] if @declaration.declaration_scope.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:contact_name] if @declaration.contact_name.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:contact_email] if @declaration.contact_email.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:contact_phone] if @declaration.contact_phone.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:authorizer] if @declaration.authorizer.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:authorizer_email] if @declaration.authorizer_email.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:authorizer_phone] if @declaration.authorizer_phone.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:effective_date] if @declaration.effective_date.to_s.empty?
    @basic << "(#{@declaration.language}): " + @messages[:declaration][:no_presence][:language] if @declaration.language.to_s.downcase != "english"
    #
    # Authorizer and Contact information must be filled in and cannot refer to each other by stating "same"
    if !(@declaration.contact_name.to_s.empty? && @declaration.authorizer.to_s.empty?) &&
       ((!@declaration.contact_name.to_s.empty? && @declaration.authorizer.to_s.downcase == 'same') ||
        (@declaration.contact_name.to_s.downcase == 'same' && @declaration.authorizer.to_s.empty?))
      @basic << @messages[:declaration][:invalid_data][:contact_and_authorizer_cannot_use_same]
    end
    #
    # If declaration of scope is User Defined, description of scope must be filled
    if @declaration.declaration_scope.to_s.downcase == "c. user defined [specify in 'description of scope']" &&
       @declaration.description_of_scope.to_s.empty?
      @basic << @messages[:declaration][:flagged][:declaration_scope][:is_user_defined_and_description_of_scope_is_empty]
    end
    #
    # Effective date should not be in the future
    @basic << @messages[:declaration][:invalid_data][:effective_date] if @declaration.effective_date && @declaration.effective_date > Time.now
  end

  def validate_minerals_fields
    @declaration.minerals_questions.sort_by(&:sequence).each_with_index do |mdec, index|
      case index
        # 1) Is the conflict intentionally added to your product? (*)
        when 0
          %w(tantalum tin gold tungsten).each do |mineral|
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
          end
          next
        # 2) Is the conflict metal necessary to the production of your company's products and contained
        # in the finished product that your company manufactures or contracts to manufacture? (*)
        when 1
          %w(tantalum tin gold tungsten).each do |mineral|
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
          end
          next
        # 3) Does any of the conflict metal originate from the covered countries? (*)
        when 2
          %w(tantalum tin gold tungsten).each do |mineral|
            next unless eval("@has_#{mineral}")
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:high_risk][mineral.to_sym] if mdec.send(mineral).to_s.downcase == 'yes'
          end
          next
        # 4) Does 100 percent of the conflict metal (necessary to the functionality or production of your
        # products) originate from recycled or scrap sources? (*)
        when 3
          %w(tantalum tin gold tungsten).each do |mineral|
            next unless eval("@has_#{mineral}")
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
          end
          next
        # 5) Have you received conflict metals data/information for each metal from all relevant
        # suppliers of 3TG? (*)
        when 4
          %w(tantalum tin gold tungsten).each do |mineral|
            next unless eval("@has_#{mineral}")
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
            if ["none", "no, but less than 25%", "no, but greater than 25%"].include?(mdec.send(mineral).to_s.downcase)
              @minerals << @messages[:minerals][index][:flagged][:less_than_50_percent][mineral.to_sym]
            end
          end
          next
        # 6) For each conflict metal, have you identified all of the smelters your company and its suppliers
        # user to supply the products included within the declaration scope indicated above? (*)
        when 5
          %w(tantalum tin gold tungsten).each do |mineral|
            next unless eval("@has_#{mineral}")
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
          end
          next
        # 7) Has all applicable smelter information received by your company been reported in this
        # declaration? (*)
        when 6
          %w(tantalum tin gold tungsten).each do |mineral|
            next unless eval("@has_#{mineral}")
            @minerals << @messages[:minerals][index][:no_presence][mineral.to_sym] if mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:invalid_data][mineral.to_sym] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.send(mineral).to_s.strip) || mdec.send(mineral).to_s.strip.empty?
            @minerals << @messages[:minerals][index][:flagged][:is_no][mineral.to_sym] if mdec.send(mineral).to_s.downcase == 'no'
          end
      end
    end

    # Cross check minerals questions
    #
    # If Question 3 is answered "No" (Unknown is okay) for any metal, then Question 5 must be answered
    # "Yes, 100%" for that metal and Question 6 must be answered "Yes" for that metal.
    %w(tantalum tin gold tungsten).each do |mineral|
      next unless eval("@has_#{mineral}")
      if @declaration.minerals_questions[2].send(mineral).to_s.downcase == 'no' &&
         @declaration.minerals_questions[4].send(mineral).to_s.downcase != 'yes, 100%' &&
         @declaration.minerals_questions[5].send(mineral).to_s.downcase != 'yes'
        @minerals << @messages[:minerals_cross_check][:question_3_is_no_and_questions_5_or_6_not_yes][mineral.to_sym]
      end
    end
    #
    # For each metal, has supplier identified all of the smelters used by the company
    # and its suppliers as per Q6
    %w(tantalum tin gold tungsten).each do |mineral|
      next unless eval("@has_#{mineral}")
      if @declaration.minerals_questions[5].send(mineral).to_s.downcase == 'yes' &&
         !@declaration.minerals_questions[4].send(mineral).to_s.downcase == 'yes, 100%'
        @minerals << @messages[:minerals_cross_check][:question_6_is_yes_and_question_5_is_not_yes][mineral.to_sym]
      end
    end

  end

  def validate_company_level_fields
    question_letters = %w(A B C D E F G H I J)
    @declaration.company_level_questions.each_with_index do |clq, index|
      if clq.is_unanswered?
        @company_level << @messages[:declaration][:no_presence][:company_level_questions] % question_letters[index]
        return
      end
    end

    @declaration.company_level_questions.sort_by(&:sequence).each_with_index do |clq, index|
      case index
        # A. Do you have a policy in place that addresses conflict minerals sourcing? (*)
        when 0
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # B. Is this policy publicly available on your website?
        when 1
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_url] if clq.answer == "Yes" && clq.comment.to_s.empty? # TODO Test whether it's a real URL instead of just empty
          next
        # C. Do you require your direct suppliers to be DRC conflict-free?
        when 2
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # D. Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?
        when 3
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # E. Have you implemented due diligence measures for conflict-free sourcing?
        when 4
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # F. Do you request your suppliers to fill out this Conflict Minerals Reporting Template?
        when 5
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no_and_has_comment] if clq.answer.to_s.downcase == "no" && clq.comment.to_s.size > 0
          @company_level << @messages[:company_level][index][:flagged][:is_no_but_no_comment]  if clq.answer.to_s.downcase == "no" && clq.comment.to_s.empty?
          next
        # G. Do you request smelter names from your suppliers?
        when 6
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # H. Do you verify due diligence information received from your suppliers?
        when 7
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # I. Does your verification process include corrective action management?
        when 8
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_comment] if clq.answer.to_s.downcase == "yes" && clq.comment.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer.to_s.downcase == "no"
          next
        # J. Are you subject to the SEC Conflict Minerals disclosure requirement rule?
        when 9
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          next
      end
    end
  end

  def validate_mineral_smelters
    @declaration.mineral_smelters.each_with_index do |smelter, index|
      spreadsheet_row_number = index + 5
      @smelters_list << @messages[:smelters_list][:no_presence][:metal] % spreadsheet_row_number if smelter.metal.to_s.empty?
      #
      # If smelter reference list is "Smelter not yet identified" and other fields include data
      if smelter.smelter_reference_list.to_s.downcase == 'smelter not yet identified'
        @smelters_list << @messages[:smelters_list][:flagged][:smelter_not_identified] % spreadsheet_row_number
        next
      end
      #
      # If smelter referencelist is "Smelter not listed", then smelter name or smelter country must have data
      if smelter.smelter_reference_list.to_s.downcase == 'smelter not listed'
        empty_required_fields = []
        {:metal => "Metal", :standard_smelter_name => "Smelter Name", :facility_location_country => "Smelter Country"}.each do |field_name, display_name|
          empty_required_fields << display_name if smelter.send(field_name).to_s.empty?
        end
        unless empty_required_fields.empty?
          @smelters_list << @messages[:smelters_list][:flagged][:smelter_not_listed_and_a_required_field_is_empty] % [spreadsheet_row_number, empty_required_fields.join(', ')]
        end
      #
      # If smelter reference list is not "Smelter not Listed", then required fields must contain data
      else
        empty_required_fields = []
        {:metal => "Metal", :smelter_reference_list => "Smelter Reference List", :standard_smelter_name => "Smelter Name", :facility_location_country => "Smelter Country"}.each do |field_name, display_name|
          empty_required_fields << display_name if smelter.send(field_name).to_s.empty?
        end
        unless empty_required_fields.empty?
          @smelters_list << @messages[:smelters_list][:flagged][:required_fields_missing] % [spreadsheet_row_number, empty_required_fields.join(', ')]
        end
      end
    end
  end

  def cross_validate_minerals_and_smelters
    sourced_minerals  = @declaration.mineral_smelters.map { |sl| sl.metal.to_s.downcase }.uniq
    %w(tantalum tin gold tungsten).each do |mineral|
      @basic << @messages[:cross_check][:minerals_and_smelters][:flagged][:declared_mineral_and_no_mineral_smelter][mineral.to_sym] if eval("@has_#{mineral}") && !sourced_minerals.include?(mineral)
      @basic << @messages[:cross_check][:minerals_and_smelters][:flagged][:no_declared_mineral_and_has_mineral_smelter][mineral.to_sym] if eval("@has_#{mineral} == false") && sourced_minerals.include?(mineral)
    end
  end

  def cross_validate_basic_and_products
    @products_list << @messages[:cross_check][:products_list][:flagged][:declaration_of_scope_is_product_and_empty_product_list] if @declaration.declaration_scope == 'B. Product (or List of Products)' && @declaration.products.empty?
  end
end
