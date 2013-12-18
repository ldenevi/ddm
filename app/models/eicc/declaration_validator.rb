class Eicc::DeclarationValidator < ActiveModel::Validator
  attr_accessor :base, :minerals, :company_level, :smelters_list, :standard_smelter_names

  attr_accessor :messages
  @messages = Eicc::Declaration.validation_messages

  def validate(record)
    raise Exception, "Report rejected: could not read file" if record.csv_worksheets.empty? || record.csv_worksheets.nil?

    @base = record.errors[:base]
    @minerals = record.errors[:minerals]
    @company_level = record.errors[:company_level]
    @smelters_list = record.errors[:smelters_list]
    @standard_smelter_names = record.errors[:standard_smelter_names]

    validate_minerals_declaration(record)

    unless record.mineral_questions.first.tantalum.to_s.strip.downcase == 'no' &&
            record.mineral_questions.first.tin.to_s.strip.downcase == 'no' &&
            record.mineral_questions.first.gold.to_s.strip.downcase == 'no' &&
            record.mineral_questions.first.tungsten.to_s.strip.downcase == 'no'
      validate_company_level_declaration(record)
    end
    cross_check_minerals_and_smelter_list(record)
  end

private
  # FIXME: This needs to be DRY'd up, once we implement the i18n
  def validate_minerals_declaration(record)
    @messages ||= Eicc::Declaration.validation_messages

    if record.mineral_questions.size == 0
      @minerals << @messages[:declaration][:no_presence][:mineral_questions]
      return
    end

    has_tantalum = false
    has_tin = false
    has_gold = false
    has_tungsten = false

    record.mineral_questions.sort_by(&:sequence).each_with_index do |mdec, index|
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

          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tantalum] if has_tantalum && mdec.tantalum.to_s.downcase == "yes all smelters have been provided" && record.mineral_questions[3].tantalum.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tin]      if has_tin && mdec.tin.to_s.downcase == "yes all smelters have been provided" && record.mineral_questions[3].tin.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:gold]     if has_gold && mdec.gold.to_s.downcase == "yes all smelters have been provided" && record.mineral_questions[3].gold.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tungsten] if has_tungsten && mdec.tungsten.to_s.downcase == "yes all smelters have been provided" && record.mineral_questions[3].tungsten.to_s.downcase != "yes"
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


  def validate_company_level_declaration(record)
    @messages ||= Eicc::Declaration.validation_messages

    if record.company_level_questions.size == 0
      @company_level << @messages[:declaration][:no_presence][:company_level_questions]
    end

    record.company_level_questions.sort_by(&:sequence).each_with_index do |clq, index|
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

  def cross_check_minerals_and_smelter_list(record)
    # TODO: This needs to be fixed. Perhaps the validation_messages YAML data should be pulled from within declaration_validator.rb (here), rather than the Declaration model. This means that all other sub-models need to have their validation code updated.
    @messages ||= Eicc::Declaration.validation_messages

    # Match mineral source if declared
    sourced_minerals  = record.smelter_list.map { |sl| sl.metal.to_s.downcase }
    declared_minerals = record.mineral_questions.first

    return if declared_minerals.nil? || sourced_minerals.empty?

    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tantalum] if declared_minerals.tantalum == "Yes" && !sourced_minerals.include?("tantalum")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tin]      if declared_minerals.tin == "Yes" && !sourced_minerals.include?("tin")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:gold]     if declared_minerals.gold == "Yes" && !sourced_minerals.include?("gold")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tungsten] if declared_minerals.tungsten == "Yes" && !sourced_minerals.include?("tungsten")
  end

  def validate_smelter_list(record)
    @messages ||= Eicc::Declaration.validation_messages
    record.smelter_list.each do |smelter|
      @smelter_list << @messages[:smelter_list][:no_presence][:standard_smelter_name] if smelter.standard_smelter_name.to_s.empty?
    end
  end
end
