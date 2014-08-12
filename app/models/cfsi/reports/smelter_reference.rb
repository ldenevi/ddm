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
      (furthest.to_f > 0.80) ? distances[furthest] : [smelter.standard_smelter_name]
    end
  end

  def self.get_gsp_standard_name_matches(smelter, args = {:use_key_terms => true})
    @@references ||= select([:standard_name, :key_terms]).all
    jaro_winkler = FuzzyStringMatch::JaroWinkler.create(:native)
    distances = {}
    smelter_name = smelter.standard_smelter_name.to_s.split("\n").sort_by { |e| e.size }.last
    @@references.each do |ref|
      perform_strip_to_key_term = true
      str1 = begin
        if smelter_name =~ /Perth Mint/ || smelter_name.downcase =~ /agr matthey/
          "Western Australian Mint trading as The Perth Mint"
        elsif smelter_name.gsub(' ', '') =~ /F&X/
          "F&X Electro-Materials Ltd."
        elsif smelter_name.downcase =~ /rfh/ && smelter.facility_location_country.downcase == 'china'
          "RFH Tantalum Smeltry Co., Ltd"
        elsif smelter_name.downcase.gsub(' ', '').gsub('.','') =~ /hcstarck/
          "H.C. Starck Group"
        elsif smelter_name =~ /PT Timah/ && smelter.smelter_id == 'CID001482'
          "PT Timah"
        elsif smelter_name.downcase =~ /johnson matthey/
          perform_strip_to_key_term = false
          if !(smelter_name.downcase =~ /ltd|limited/) && smelter.facility_location_country.downcase =~ /united states/
            "Johnson Matthey Inc"
          else
            smelter_name
          end
        elsif smelter_name.downcase =~ /xstrata/
          "CCR Refinery Glencore Canada Corporation"
        elsif smelter_name.downcase =~ /thailand/ && smelter_name.downcase =~ /smelting/ && smelter_name.downcase =~ /refining/
          "Thaisarco"
        elsif smelter_name.downcase =~ /ati\b/ && smelter.metal.downcase == 'tungsten'
          "Kennametal Huntsville"
        elsif smelter_name.downcase =~ /nusantara/
          smelter_name
        elsif smelter_name.downcase =~ /cookson/
          "Alpha"
        elsif smelter_name.downcase =~ /aurubis/
          "Aurubis AG"
        elsif smelter_name.downcase =~ /asahi|amagasaki/
          "Asahi Pretec Corporation"
        elsif smelter_name.downcase =~ /\bdowa\b/
          "Dowa"
        elsif smelter_name.downcase =~ /jx nippon|pan pacific copper/
          "JX Nippon Mining & Metals Co., Ltd."
        elsif smelter_name.downcase =~ /\bmitsui\b/
          "Mitsui Mining and Smelting Co., Ltd."
        elsif smelter_name.downcase =~ /\btanaka\b/
          "Tanaka Kikinzoku Kogyo K.K."
        elsif smelter_name.downcase =~ /tokuriki/
          "Tokuriki Honten Co., Ltd"
        elsif smelter_name.downcase =~ /central/ && smelter_name.downcase =~ /bank/ && smelter_name.downcase =~ /philippines/
          "Bangko Sentral ng Pilipinas (Central Bank of the Philippines)"
        elsif smelter_name.downcase =~ /caridad/ && smelter.facility_location_country.downcase == 'mexico'
          "Caridad"
        elsif smelter_name.downcase =~ /\bsempsa\b/
          "SEMPSA Joyera Platera SA"
        elsif smelter_name.downcase =~ /\bmetalor\b/
          if smelter_name.downcase =~ /hong kong/
            "Metalor Technologies (Hong Kong) Ltd"
          elsif smelter_name.downcase =~ /singapore/
            "Metalor Technologies (Singapore) Pte. Ltd."
          elsif smelter_name.downcase =~ /\busa\b/
            "Metalor USA Refining Corporation"
          else
            "Metalor Technologies SA"
          end
        elsif smelter_name.downcase =~ /\bsolar\b/
          "Solar Applied Materials Technology Corp."
        elsif smelter_name.downcase =~ /\bnavoi\b/
          "Navoi Mining and Metallurgical Combinat"
        elsif smelter.facility_location_country.downcase =~ /bolivia/
          if smelter_name.downcase =~ /vinto/ || smelter_name.downcase =~ /enaf/
            "EM Vinto"
          else
            smelter_name
          end
        elsif smelter_name.downcase.gsub(/\W/, '') =~ /yunnantin|ytcl/
          "Yunnan Tin Company, Ltd."
        elsif smelter_name.downcase =~ /china tin/
          "Liuzhou China Tin"
        elsif smelter_name.downcase.gsub(/\W/, '') =~ /zili/ && smelter.facility_location_country.downcase =~ /china/
          "Gejiu Zi-Li"
        elsif smelter_name.downcase =~ /kai/ && smelter_name.downcase =~ /unita|union/
          "Kai Unita Trade Limited Liability Company"
        elsif smelter_name.downcase =~ /msc/ && smelter.facility_location_country.downcase =~ /malaysia/
          "Malaysia Smelting Corporation (MSC)"
        elsif smelter_name.downcase =~ /minsur|funsur|amalgamated metal/ && smelter.facility_location_country.downcase =~ /peru/
          "Minsur"
        elsif smelter_name.downcase =~ /ulba/ && smelter.facility_location_country.downcase =~ /kazakhstan/
          "Ulba"
        elsif smelter_name.downcase =~ /china minmetal/
          "China Minmetals Nonferrous Metals Co Ltd"
        elsif smelter_name.downcase.gsub(/\W/, '') =~ /seadragon|grandsea/
          "Ganzhou Seadragon W & Mo Co., Ltd."
        elsif smelter_name.downcase.gsub(/\W/, '') =~ /rareearth/ && smelter.facility_location_country.downcase =~ /china/
          "Ganzhou Non-ferrous Metals Smelting Co., Ltd."
        elsif smelter_name.downcase.gsub(/\W/, '') =~ /umicore/
          if smelter.facility_location_country.downcase =~ /brazil/
            "Umicore Brasil Ltda"
          elsif smelter.facility_location_country.downcase =~ /thailand/
            "Umicore Precious Metals Thailand"
          else
            smelter_name
          end
        else
          smelter_name
        end
      end
      str1 = perform_strip_to_key_term ? strip_to_key_terms(str1) : str1
      str2 = perform_strip_to_key_term ? strip_to_key_terms(ref.standard_name) : ref.standard_name
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
