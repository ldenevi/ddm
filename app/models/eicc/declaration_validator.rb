class Eicc::DeclarationValidator < ActiveModel::Validator
  attr_accessor :base

  def validate(record)
    @base = record.errors[:base]
    validate_minerals_declaration(record)
    validate_company_level_declaration(record)
  end
  
private
  def validate_minerals_declaration(record)
    if record.mineral_questions.size == 0
      @base << "No minerals review declared"
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
          @base << (marked % ["Tantalum", "D40"]) if mdec.tantalum_comment.to_s.scan(/\d{1,2}%/).first.to_i
          @base << (marked % ["Tin", "D41"])      if mdec.tin_comment.to_s.scan(/\d{1,2}%/).first.to_i
          @base << (marked % ["Gold", "D42"])     if mdec.gold_comment.to_s.scan(/\d{1,2}%/).first.to_i
          @base << (marked % ["Tungsten", "D43"]) if mdec.tungsten_comment.to_s.scan(/\d{1,2}%/).first.to_i
          next
        when 4
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
      @base << "No replies for company level questions found"
    end
    @base << "Company level replies marked as high risk" if record.company_level_questions.map(&:answer).include?("No")
  end
end
