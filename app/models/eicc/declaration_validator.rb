class Eicc::DeclarationValidator < ActiveModel::Validator
  attr_accessor :base

  def validate(record)
    @base = record.errors[:base]
    validate_minerals_declaration(record)
    validate_company_level_declaration(record)
    cross_check_minerals_and_smelter_list(record)
  end
  
private
  def validate_minerals_declaration(record)
    if record.mineral_questions.size == 0
      @base << "High risk: No minerals review declared"
      return
    end
    
    marked = "%s declaration (%s) marked as high risk"
    mismatch = "Data mismatch between %s and %s"
    
    record.mineral_questions.each_with_index do |mdec, index|
      case index
        when 1
          @base << (marked % ["Tantalum", "D28"]) if mdec.tantalum.to_s.downcase == "yes"
          @base << (marked % ["Tin", "D29"])      if mdec.tin.to_s.downcase == "yes"
          @base << (marked % ["Gold", "D30"])     if mdec.gold.to_s.downcase == "yes"
          @base << (marked % ["Tungsten", "D31"]) if mdec.tungsten.to_s.downcase == "yes"
          next
        when 3
          @base << (marked % ["Tantalum", "D40"]) if ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tantalum.to_s.strip)
          @base << (marked % ["Tin", "D41"])      if ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tin.to_s.strip)
          @base << (marked % ["Gold", "D42"])     if ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.gold.to_s.strip)
          @base << (marked % ["Tungsten", "D43"]) if ["No but > 25%", "No but < 25%", "No - none"].include?(mdec.tungsten.to_s.strip)
          next
        when 4
          # TODO Test to validate that supplier received 100% supplier responses, if it claims to have identified all smelters
          @base << (mismatch % ["Tantalum (D46)", "Tantalum (D40)"]) if mdec.tantalum.to_s.downcase == "yes" && record.mineral_questions[3].tantalum.to_s.downcase != "yes"
          @base << (mismatch % ["Tin (D47)", "Tin (D41)"])           if mdec.tin.to_s.downcase == "yes" && record.mineral_questions[3].tin.to_s.downcase != "yes"
          @base << (mismatch % ["Gold (D48)", "Gold (D42)"])         if mdec.gold.to_s.downcase == "yes" && record.mineral_questions[3].gold.to_s.downcase != "yes"
          @base << (mismatch % ["Tungsten (D49)", "Tungsten (D49)"]) if mdec.tungsten.to_s.downcase == "yes" && record.mineral_questions[3].tungsten.to_s.downcase != "yes"
          next
        when 5
          @base << (marked % ["Question", "B51"]) if [mdec.tantalum, mdec.tin, mdec.gold, mdec.tungsten].uniq.first != "Yes"
          next
      end
    end
  end
  
  
  def validate_company_level_declaration(record)
    if record.company_level_questions.size == 0
      @base << "High risk: No answers for company level questions found"
    end
    @base << "Company level replies marked as high risk" unless record.company_level_questions.map(&:answer).uniq == ["Yes"]
    
    record.company_level_questions.each_with_index do |clq, index|
      case index
        when 1
          @base << "High risk: No website address provided for publicly accessible policy" if clq.answer == "Yes" && clq.comment.to_s.empty?
          next
        when 5
          @base << "High risk: No alternative described for question B69" if clq.answer == "No" && clq.comment.to_s.empty?
          next
        when 8
          @base << "High risk: No description of corrective action management in G75" if clq.answer == "Yes" && clq.comment.to_s.empty?
          next
      end
    end
  end
  
  def cross_check_minerals_and_smelter_list(record)
    # Match mineral source if declared
    sourced_minerals  = record.smelter_list.map { |sl| sl.metal.to_s.downcase }
    declared_minerals = record.mineral_questions.first
    
    return if declared_minerals.nil? || sourced_minerals.empty?
    
    @base << "High risk: Tantalum declared on D22, but no Tantalum source found in smelter list" unless declared_minerals.tantalum == "Yes" && sourced_minerals.include?("tantalum")
    @base << "High risk: Tin declared on D23, but no Tin source found in smelter list"           unless declared_minerals.tin == "Yes" && sourced_minerals.include?("tin")
    @base << "High risk: Gold declared on D24, but no Gold source found in smelter list"         unless declared_minerals.gold == "Yes" && sourced_minerals.include?("gold")
    @base << "High risk: Tungsten declared on D25, but no Tungsten source found in smelter list" unless declared_minerals.tungsten == "Yes" && sourced_minerals.include?("tungsten")
  end
end
