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
    validate_company_level_declaration(record)
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
    
    record.mineral_questions.each_with_index do |mdec, index|
      case index
        when 4
          # TODO Test to validate that supplier received 100% supplier responses, if it claims to have identified all smelters
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tantalum] if mdec.tantalum.to_s.downcase == "yes" && record.mineral_questions[3].tantalum.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tin]      if mdec.tin.to_s.downcase == "yes" && record.mineral_questions[3].tin.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:gold]     if mdec.gold.to_s.downcase == "yes" && record.mineral_questions[3].gold.to_s.downcase != "yes"
          @minerals << @messages[:minerals][index][:flagged][:is_yes_but_q4_is_not_yes][:tungsten] if mdec.tungsten.to_s.downcase == "yes" && record.mineral_questions[3].tungsten.to_s.downcase != "yes"
          next
      end
    end
  end
  
  
  def validate_company_level_declaration(record)
    @messages ||= Eicc::Declaration.validation_messages
    
    if record.company_level_questions.size == 0
      @company_level << @messages[:declaration][:no_presence][:company_level_questions]
    end
    
    record.company_level_questions.each_with_index do |clq, index|
      case index
        # A. Do you have a policy in place that includes DRC conflict-free sourcing?
        when 0
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        # B. Is this policy publicly available on your website?
        when 1
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)          
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_url] if clq.answer == "Yes" && clq.comment.to_s.empty? # TODO Test whether it's a real URL instead of just empty
          next
        # C. Do you require your direct suppliers to be DRC conflict-free?
        when 2
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer == "No"
          next
        # D. Do you require your direct suppliers to source from smelters validated as compliant to a CFS protocol using the CFS Compliant Smelter List?
        when 3
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # E. Have you implemented due diligence measures for conflict-free sourcing?
        when 4
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # F. Do you request your suppliers to fill out this Conflict Minerals Reporting Template?
        when 5
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_no_and_has_comment] if clq.answer == "No" && clq.comment.to_s.size > 0
          @company_level << @messages[:company_level][index][:flagged][:is_no_but_no_comment]  if clq.answer == "No" && clq.comment.to_s.empty?
          next
        # G. Do you request smelter names from your suppliers?
        when 6
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # H. Do you verify due diligence information received from your suppliers?
        when 7
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_no] if clq.answer == "No"
          next
        # I. Does your verification process include corrective action management?
        when 8
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
          @company_level << @messages[:company_level][index][:flagged][:is_yes_but_no_comment] if clq.answer == "Yes" && clq.comment.to_s.empty?
          next
        # J. Are you subject to the SEC Conflict Minerals disclosure requirement rule?
        when 9
          @company_level << @messages[:company_level][index][:no_presence] if clq.answer.to_s.empty?
          @company_level << @messages[:company_level][index][:invalid_data][:message] unless @messages[:company_level][index][:invalid_data][:expected].include?(clq.answer.to_s)
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
    
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tantalum] unless declared_minerals.tantalum == "Yes" && sourced_minerals.include?("tantalum")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tin]      unless declared_minerals.tin == "Yes" && sourced_minerals.include?("tin")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:gold]     unless declared_minerals.gold == "Yes" && sourced_minerals.include?("gold")
    @base << @messages[:cross_check][:minerals_question_1][:flagged][:tungsten] unless declared_minerals.tungsten == "Yes" && sourced_minerals.include?("tungsten")
  end
end
