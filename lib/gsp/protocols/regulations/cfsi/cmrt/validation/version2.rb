module GSP::Protocols::Regulations::CFSI::CMRT::Validation::Version2
  attr_accessor :messages
  attr_accessor :declaration
  attr_accessor :basic, :minerals, :company_level, :smelters_list, :standard_smelter_names

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
    unless @declaration.minerals_questions.first.tantalum.to_s.strip.downcase == 'no' &&
            @declaration.minerals_questions.first.tin.to_s.strip.downcase == 'no' &&
            @declaration.minerals_questions.first.gold.to_s.strip.downcase == 'no' &&
            @declaration.minerals_questions.first.tungsten.to_s.strip.downcase == 'no'
      validate_company_level_fields
    end
    cross_validate_minerals_and_smelters
    validate_mineral_smelters
  end

  def validate_basic_fields
    @basic << @messages[:declaration][:no_presence][:company_name] if @declaration.company_name.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:declaration_scope] if @declaration.declaration_scope.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:authorized_company_representative_name] if @declaration.authorized_company_representative_name.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:representative_email] if @declaration.contact_email.to_s.empty?
    @basic << @messages[:declaration][:no_presence][:completion_at] if @declaration.completion_at.to_s.empty?
    @basic << "(#{@declaration.language}): " + @messages[:declaration][:no_presence][:language] if @declaration.language.to_s.empty?
  end

  def validate_minerals_fields
    if @declaration.minerals_questions.size == 0
      @minerals << @messages[:declaration][:no_presence][:mineral_questions]
      return
    end

    has_tantalum = false
    has_tin = false
    has_gold = false
    has_tungsten = false

    @declaration.minerals_questions.sort_by(&:sequence).each_with_index do |mdec, index|
      case index
        # 1) Are any of the following metals necessary to the functionality or production of your company's products that it manufactures or contracts to manufacture?
        when 0
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin] if mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold] if mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?

          has_tantalum = true if mdec.tantalum.to_s.strip.downcase == "yes"
          has_tin = true      if mdec.tin.to_s.strip.downcase == "yes"
          has_gold = true     if mdec.gold.to_s.strip.downcase == "yes"
          has_tungsten = true if mdec.tungsten.to_s.strip.downcase == "yes"
          next
        # 2) Do the following metals (necessary to the functionality or production of your company's products) originate from the DRC or an adjoining country?
        # TODO For the next 2 years (since Oct 2013), "Uncertain or Unknown" does not raise a high risk flag.
        when 1
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if has_tantalum && mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin]      if has_tin && mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold]     if has_gold && mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if has_tungsten && mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless has_tantalum == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin]      unless has_tin == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold]     unless has_gold == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless has_tungsten == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:flagged][:is_yes][:tantalum] if has_tantalum && mdec.tantalum.to_s.downcase == "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes][:tin]      if has_tin && mdec.tin.to_s.downcase == "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes][:gold]     if has_gold && mdec.gold.to_s.downcase == "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes][:tungsten] if has_tungsten && mdec.tungsten.to_s.downcase == "yes"
          next
        # 3) Do the following metals (necessary to the functionality or production of your products) come from a recycler or scrap supplier?
        when 2
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if has_tantalum && mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin]      if has_tin && mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold]     if has_gold && mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if has_tungsten && mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless has_tantalum == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin]      unless has_tin == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold]     unless has_gold == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless has_tungsten == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?
          next
        # 4) Have you received completed Conflict Minerals Reporting Templates from all of your suppliers?
        when 3
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if has_tantalum && mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin]      if has_tin && mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold]     if has_gold && mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if has_tungsten && mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless has_tantalum == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin]      unless has_tin == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold]     unless has_gold == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless has_tungsten == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:flagged][:is_no_and_less_than_50_percent][:tantalum] if has_tantalum && ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tantalum.to_s.downcase)
          @minerals << @messages[:minerals][index][:flagged][:is_no_and_less_than_50_percent][:tin]      if has_tin && ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tin.to_s.downcase)
          @minerals << @messages[:minerals][index][:flagged][:is_no_and_less_than_50_percent][:gold]     if has_gold && ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.gold.to_s.downcase)
          @minerals << @messages[:minerals][index][:flagged][:is_no_and_less_than_50_percent][:tungsten] if has_tungsten && ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tungsten.to_s.downcase)
          next
        # 5) For each of the following metals, have you identified all of the smelters your company and its suppliers use to supply the products included within the declaration scope indicated above?
        when 4
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if has_tantalum && mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin]      if has_tin && mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold]     if has_gold && mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if has_tungsten && mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless has_tantalum == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin]      unless has_tin == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold]     unless has_gold == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless has_tungsten == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tantalum] if has_tantalum && mdec.tantalum.to_s.downcase == "yes all smelters have been provided" && @declaration.minerals_questions[3].tantalum.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tin]      if has_tin && mdec.tin.to_s.downcase == "yes all smelters have been provided" && @declaration.minerals_questions[3].tin.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:gold]     if has_gold && mdec.gold.to_s.downcase == "yes all smelters have been provided" && @declaration.minerals_questions[3].gold.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tungsten] if has_tungsten && mdec.tungsten.to_s.downcase == "yes all smelters have been provided" && @declaration.minerals_questions[3].tungsten.to_s.downcase != "yes"
          next
        # 6) Have all of the smelters used by your company and its suppliers been validated as compliant in accordance with the Conflict-Free Smelter (CFS) Program and listed on the Compliant Smelter List for the following metals?
        when 5
          @minerals << @messages[:minerals][index][:no_presence][:tantalum] if has_tantalum && mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tin]      if has_tin && mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:gold]     if has_gold && mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:no_presence][:tungsten] if has_tungsten && mdec.tungsten.to_s.strip.empty?

          @minerals << @messages[:minerals][index][:invalid_data][:tantalum] unless has_tantalum == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tantalum.to_s.strip) || mdec.tantalum.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tin]      unless has_tin == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tin.to_s.strip) || mdec.tin.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:gold]     unless has_gold == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.gold.to_s.strip) || mdec.gold.to_s.strip.empty?
          @minerals << @messages[:minerals][index][:invalid_data][:tungsten] unless has_tungsten == false || @messages[:minerals][index][:invalid_data][:expected].include?(mdec.tungsten.to_s.strip) || mdec.tungsten.to_s.strip.empty?
          next
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
        # A. Do you have a policy in place that includes DRC conflict-free sourcing?
        when 0
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes" && !clq.answer.to_s.empty?
          next
        # B. Is this policy publicly available on your website?
        when 1
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_url] if clq.answer == "Yes" && clq.comment.to_s.empty? # TODO Test whether it's a real URL instead of just empty
          next
        # C. Do you require your direct suppliers to be DRC conflict-free?
        when 2
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer == "No"
          next
        # D. Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?
        when 3
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # E. Have you implemented due diligence measures for conflict-free sourcing?
        when 4
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # F. Do you request your suppliers to fill out this Conflict Minerals Reporting Template?
        when 5
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no_and_has_comment] if clq.answer == "No" && clq.comment.to_s.size > 0
          @company_level << @messages[:company_level][index][:flagged][:is_no_but_no_comment]  if clq.answer == "No" && clq.comment.to_s.empty?
          next
        # G. Do you request smelter names from your suppliers?
        when 6
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # H. Do you verify due diligence information received from your suppliers?
        when 7
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # I. Does your verification process include corrective action management?
        when 8
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_comment] if clq.answer == "Yes" && clq.comment.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # J. Are you subject to the SEC Conflict Minerals disclosure requirement rule?
        when 9
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s) || clq.answer.to_s.empty?
          next
      end
    end
  end

  def cross_validate_minerals_and_smelters
    # Match mineral source if declared
    sourced_minerals  = @declaration.mineral_smelters.map { |sl| sl.metal.to_s.downcase }
    declared_minerals = @declaration.minerals_questions.first

    return if declared_minerals.nil? && sourced_minerals.empty?

    @basic << @messages[:cross_check][:minerals_question_1][:flagged][:tantalum] if declared_minerals.tantalum == "Yes" && !sourced_minerals.include?("tantalum")
    @basic << @messages[:cross_check][:minerals_question_1][:flagged][:tin]      if declared_minerals.tin == "Yes" && !sourced_minerals.include?("tin")
    @basic << @messages[:cross_check][:minerals_question_1][:flagged][:gold]     if declared_minerals.gold == "Yes" && !sourced_minerals.include?("gold")
    @basic << @messages[:cross_check][:minerals_question_1][:flagged][:tungsten] if declared_minerals.tungsten == "Yes" && !sourced_minerals.include?("tungsten")
  end

  def validate_mineral_smelters
    @declaration.mineral_smelters.each do |smelter|
      if smelter.standard_smelter_name.to_s.empty? && smelter.smelter_reference_list.to_s.downcase == 'smelter not listed'
        @smelters_list << @messages[:smelters_list][:no_presence][:standard_smelter_name]
        break
      end
    end
  end
end
