require 'fuzzystringmatch'
require 'gsp/ext/ruby'

class Cfsi::Reports::SmelterReference < ActiveRecord::Base
  attr_accessible :country, :key_terms, :metal, :standard_name, :v2_smelter_id, :v3_smelter_id
  serialize :key_terms, Array

  def self.import_from_csv(csv)
    array = csv.to_a
    ActiveRecord::Base.transaction do
      array[1..-1].each do |row|
        create :metal => row[0].to_s.strip,
               :country => row[1].to_s.strip,
               :standard_name => row[2].to_s.strip,
               :key_terms => [row[3], row[4], row[5], row[6]].map(&:to_s).map(&:strip),
               :v2_smelter_id => row[7].to_s.strip,
               :v3_smelter_id => row[8].to_s.strip
      end
    end
  end

  def self.import_from_csv_file_path(file_path)
    data = File.read(file_path)
    csv  = CSV.new(data)
    import_from_csv(csv)
  end

  def self.get_standard_names_for(smelter, args = {:use_key_terms => true})
    if smelter.standard_smelter_name.to_s.empty?
      []
    else
      distances = get_gsp_standard_name_matches(smelter, args)
      furthest  = distances.keys.max
      (furthest.to_f > 0.84) ? ["(#{furthest}) " + distances[furthest].first] : [smelter.standard_smelter_name]
    end
  end

  def self.get_gsp_standard_name_matches(smelter, args = {:use_key_terms => true})
    @@references ||= select([:standard_name, :key_terms]).all
    jaro_winkler = FuzzyStringMatch::JaroWinkler.create(:native)
    distances = {}
    smelter_name = smelter.standard_smelter_name.to_s.split("\n").sort_by { |e| e.size }.last
    @@references.each do |ref|
      str1 = begin
        if smelter_name =~ /Perth Mint/
          "Western Australian Mint trading as The Perth Mint"
        elsif smelter_name.gsub(' ', '') =~ /F&X/
          "F&X Electro-Materials Ltd."
        else
          smelter_name
        end
      end
      str1 = strip_to_key_terms(str1)
      str2 = strip_to_key_terms(ref.standard_name)
      dist = jaro_winkler.getDistance(str1, str2)
      distances[dist] = [] if distances[dist].nil?
      distances[dist] << ref.standard_name
    end
    distances
  end

  def self.strip_to_key_terms(string)
    legal_words = %w(pt corp corporation co company ltd ltda limited llc spa sa ag gmbh inc pllc kg jsc pte)
    regexp = Regexp.new('\b' + (['\W'] + legal_words).join('\b|\b') + '\b')
    string.gsub(/[.,]/,'').downcase.gsub(regexp, '')
  end

end
