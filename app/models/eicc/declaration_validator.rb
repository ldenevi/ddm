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
        when 0
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 1
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          @base << @messages[:company_level][index][:flagged][:is_yes_but_no_url] if clq.answer == "Yes" && clq.comment.to_s.empty?
          next
        when 2
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 3
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 4
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 5
         @base << @messages[:company_level][index][:flagged][:is_no_but_no_comment] if clq.answer == "No" && clq.comment.to_s.empty?
          next
        when 6
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 7
          @base << @messages[:company_level][index][:flagged][:is_not_yes] if clq.answer != "Yes"
          next
        when 8
          @base << @messages[:company_level][index][:flagged][:is_yes_but_no_comment] if clq.answer == "Yes" && clq.comment.to_s.empty?
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
