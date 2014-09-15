# ReportsHelper is intended to reduce the repetive code used in CMRT related reports.
# Additionally, this aids in documenting the programmatic definitions of business concerns.
# 

module GSP::Protocols::Regulations::CFSI::Reports::DeclarationHelper
  def major_version
    version.split('.').first
  end
  
  def is_version_2?
    !(version =~ /^2/).nil?
  end
  
  def is_version_3?
    !(version =~ /^3/).nil?
  end
  
  #
  # Has it been declared that any of the key minerals originate from the DRC or any adjoining nation?
  #
  def has_tantalum_from_conflict_zone?
    if is_version_2?
      !(minerals_questions[1].tantalum.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[2].tantalum.to_s.downcase =~ /yes/).nil?
    end
  end
  def has_tin_from_conflict_zone?
    if is_version_2?
      !(minerals_questions[1].tin.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[2].tin.to_s.downcase =~ /yes/).nil?
    end
  end
  def has_gold_from_conflict_zone?
    if is_version_2?
      !(minerals_questions[1].gold.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[2].gold.to_s.downcase =~ /yes/).nil?
    end
  end
  def has_tungsten_from_conflict_zone?
    if is_version_2?
      !(minerals_questions[1].tungsten.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[2].tungsten.to_s.downcase =~ /yes/).nil?
    end
  end
    
  #
  # Has it been declared that the supplier use any of the key minerals?
  #
  def has_tantalum?
    if is_version_2?
      !(minerals_questions[0].tantalum.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !("#{minerals_questions[0].tantalum.to_s.downcase} #{minerals_questions[1].tantalum.to_s.downcase}" =~ /yes/).nil?
    end
  end
  def has_tin?
    if is_version_2?
      !(minerals_questions[0].tin.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !("#{minerals_questions[0].tin.to_s.downcase} #{minerals_questions[1].tin.to_s.downcase}" =~ /yes/).nil?
    end
  end
  def has_gold?
    if is_version_2?
      !(minerals_questions[0].gold.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !("#{minerals_questions[0].gold.to_s.downcase} #{minerals_questions[1].gold.to_s.downcase}" =~ /yes/).nil?
    end
  end
  def has_tungsten?
    if is_version_2?
      !(minerals_questions[0].tungsten.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !("#{minerals_questions[0].tungsten.to_s.downcase} #{minerals_questions[1].tungsten.to_s.downcase}" =~ /yes/).nil?
    end
  end
  def has_any_key_metal?
    has_tantalum? || has_tin? || has_gold? || has_tungsten?
  end
  
  #
  # Number of key or conflict minerals reported
  #
  def number_of_key_minerals
    ([has_tantalum?, has_tin?, has_gold?, has_tungsten?] - [false]).size
  end
  def number_of_conflict_minerals
    ([has_tantalum_from_conflict_zone?, has_tin_from_conflict_zone?, has_gold_from_conflict_zone?, has_tungsten_from_conflict_zone?] - [false]).size
  end
  
  #
  # Declared that all key minerals suppliers were identified
  #
  def are_all_tantalum_smelters_identified?
    if is_version_2?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[5].tantalum.to_s.downcase =~ /yes/).nil?
    end
  end
  def are_all_tin_smelters_identified?
    if is_version_2?
      !(minerals_questions[4].tin.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[5].tin.to_s.downcase =~ /yes/).nil?
    end
  end
  def are_all_gold_smelters_identified?
    if is_version_2?
      !(minerals_questions[4].gold.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[5].gold.to_s.downcase =~ /yes/).nil?
    end
  end
  def are_all_tungsten_smelters_identified?
    if is_version_2?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[5].tungsten.to_s.downcase =~ /yes/).nil?
    end
  end
  
  #
  # Supplier response percentage
  #
  def have_100_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /yes/).nil?
    end
  end
  def have_100_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /yes/).nil?
    end
  end
  def have_100_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /yes/).nil?
    end
  end
  def have_100_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /yes/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /yes/).nil?
    end
  end
  
  def have_75_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /75/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /75/).nil?
    end
  end
  def have_75_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /75/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /75/).nil?
    end
  end
  def have_75_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /75/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /75/).nil?
    end
  end
  def have_75_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /75/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /75/).nil?
    end
  end
  
  def have_50_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /50/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /50/).nil?
    end
  end
  def have_50_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /50/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /50/).nil?
    end
  end
  def have_50_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /50/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /50/).nil?
    end
  end
  def have_50_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /50/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /50/).nil?
    end
  end
  
  def have_25_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /> 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /greater than 25/).nil?
    end
  end
  def have_25_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /> 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /greater than 25/).nil?
    end
  end
  def have_25_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /> 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /greater than 25/).nil?
    end
  end
  def have_25_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /> 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /greater than 25/).nil?
    end
  end
  
  def have_1_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /< 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /less than 25/).nil?
    end
  end
  def have_1_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /< 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /less than 25/).nil?
    end
  end
  def have_1_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /< 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /less than 25/).nil?
    end
  end
  def have_1_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /< 25/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /less than 25/).nil?
    end
  end
  
  def have_0_percent_of_tantalum_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tantalum.to_s.downcase =~ /none/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tantalum.to_s.downcase =~ /none/).nil?
    end
  end
  def have_0_percent_of_tin_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tin.to_s.downcase =~ /none/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tin.to_s.downcase =~ /none/).nil?
    end
  end
  def have_0_percent_of_gold_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].gold.to_s.downcase =~ /none/).nil?
    elsif is_version_3?
      !(minerals_questions[4].gold.to_s.downcase =~ /none/).nil?
    end
  end
  def have_0_percent_of_tungsten_suppliers_responded?
    if is_version_2?
      !(minerals_questions[3].tungsten.to_s.downcase =~ /none/).nil?
    elsif is_version_3?
      !(minerals_questions[4].tungsten.to_s.downcase =~ /none/).nil?
    end
  end
  
  #
  # Declared conflict minerals policy is in place
  #
  def has_policy_in_place?
    !(company_level_questions[0].answer.to_s.downcase =~ /yes/).nil?
  end
  
  def has_policy_on_website?
    !(company_level_questions[1].answer.to_s.downcase =~ /yes/).nil?
  end
  
  def is_subject_to_sec?
    !(company_level_questions[9].answer.to_s.downcase =~ /yes/).nil?
  end
end
