module GSP::Protocols::Regulations::CFSI::CMRT::Validation::Version3
  attr_accessor :messages
  attr_accessor :declaration
  attr_accessor :basic, :minerals, :company_level, :smelters_list, :standard_smelter_names
  attr_accessor :has_tantalum, :has_tin, :has_gold, :has_tungsten

  def load_messages
    @messages = YAML::load_file(File.join('config', 'cfsi', @declaration.version, 'messages.en.yml'))["en"]
    @basic = @declaration.errors[:base]
    @minerals = @declaration.errors[:minerals]
    @company_level = @declaration.errors[:company_level]
    @smelters_list = @declaration.errors[:smelters_list]
    @standard_smelter_names = @declaration.errors[:standard_smelter_names]
  end

  def run_validations(declaration)
    @declaration = declaration
    load_messages
    validate_basic_fields
    validate_minerals_fields
    if is_in_scope?
      validate_company_level_fields
      cross_validate_minerals_and_smelters
      validate_mineral_smelters
    end
  end

  def is_in_scope?
    %w(tantalum tin gold tungsten).each do |mineral|
      has_mineral = (@declaration.minerals_questions[0].send(mineral).to_s.downcase == 'yes' || @declaration.minerals_questions[1].send(mineral).to_s.downcase == 'yes')
      eval("@has_#{mineral} = has_mineral")
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
    if @declaration.minerals_questions.size == 0
      @minerals << @messages[:declaration][:no_presence][:mineral_questions]
      return
    end

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
         @declaration.minerals_questions[4].send(mineral).to_s.downcase == 'yes, 100%' &&
         @declaration.minerals_questions[5].send(mineral).to_s.downcase == 'yes'
        @minerals << @messages[:minerals_cross_check][:question_3_is_no_and_questions_5_or_6_not_yes][mineral.to_sym]
      end
    end
    #
    # Question 4 must be answered for each metal listed in Q1 or Q2 as "Yes"
    %w(tantalum tin gold tungsten).each do |mineral|
      next unless eval("@has_#{mineral}")
      if @declaration.minerals_questions[3].send(mineral).to_s.empty? &&
         (@declaration.minerals_questions[0].send(mineral).to_s.downcase == 'yes' ||
          @declaration.minerals_questions[1].send(mineral).to_s.downcase == 'yes')
        @minerals << @messages[:minerals_cross_check][:question_4_is_empty_and_question_1_or_2_yes][mineral.to_sym]
      end
    end
    #
    # If the answer for any metal in Q1 or Q2 is "Yes", there must be an answer for
    # that metal in Q7
    %w(tantalum tin gold tungsten).each do |mineral|
      next unless eval("@has_#{mineral}")
      unless (@declaration.minerals_questions[0].send(mineral).to_s.downcase == 'yes' ||
               @declaration.minerals_questions[1].send(mineral).to_s.downcase == 'yes') &&
               !@declaration.minerals_questions[1].send(mineral).to_s.empty?
        @minerals << @messages[:minerals_cross_check][:question_1_or_2_is_yes_and_question_7_is_empty][mineral.to_sym]
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
    if @declaration.company_level_questions.size == 0
      @company_level << @messages[:declaration][:no_presence][:company_level_questions]
      return
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
    @declaration.mineral_smelters.each do |smelter|
      if smelter.smelter_reference_list.to_s.empty?
        @smelters_list << @messages[:smelters_list][:no_presence][:smelter_reference_list]
        break
      end
      @smelters_list << @messages[:smelters_list][:no_presence][:metal] if smelter.metal.to_s.empty?
      #
      # If smelter reference list is "Smelter not yet identified" and other fields include data
      other_fields = ["facility_contact_email", "facility_contact_name", "facility_location_city", "facility_location_country", "facility_location_province", "facility_location_street_address",
                      "is_all_smelter_feedstock_from_recycled_sources", "mineral_source", "mineral_source_location", "proposed_next_steps", "smelter_id", "source_of_smelter_id", "standard_smelter_name"]
      other_fields.collect! { |attr| smelter.send(attr) }
      if smelter.smelter_reference_list.to_s.downcase == 'smelter not yet identified' && !other_fields.compact.empty?
        @smelters_list << @messages[:smelters_list][:flagged][:smelter_not_identified_and_fields_have_data]
      end
      #
      # If smelter referencelist is "Smelter not listed", then smelter name and smelter country must have data
      if smelter.smelter_reference_list.to_s.downcase == 'smelter not listed' &&
         (smelter.standard_smelter_name.to_s.empty? || smelter.facility_location_country.to_s.empty?)
        @smelters_list << @messages[:smelters_list][:flagged][:smelter_not_listed_and_fields_have_no_data]
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
end
