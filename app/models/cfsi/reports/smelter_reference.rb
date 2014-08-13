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
    @@references ||= select([:standard_name]).all
    jaro_winkler = FuzzyStringMatch::JaroWinkler.create(:native)
    distances = {}
    smelter_name = smelter.standard_smelter_name.to_s.downcase
    @@references.each do |ref|
      perform_strip_to_key_term = true
      str1 = begin
        if smelter_name =~ /perth mint/ || smelter_name =~ /agr matthey/
          "Western Australian Mint trading as The Perth Mint"
        elsif smelter_name.gsub(' ', '') =~ /f&x/
          "F&X Electro-Materials Ltd."
        elsif smelter_name =~ /rfh/ && smelter.facility_location_country.downcase == 'china'
          "RFH Tantalum Smeltry Co., Ltd"
        elsif smelter_name.gsub(/\W/,'') =~ /hcstarck/
          "H.C. Starck Group"
        elsif smelter_name =~ /pt timah/ && smelter.smelter_id == 'CID001482'
          "PT Timah"
        elsif smelter_name =~ /johnson matthey/
          perform_strip_to_key_term = false
          if !(smelter_name =~ /ltd|limited/) && smelter.facility_location_country.downcase =~ /united states/
            "Johnson Matthey Inc"
          elsif smelter_name =~ /canada/
            "Johnson Matthey Ltd"
          else
            smelter_name
          end
        elsif smelter_name =~ /xstrata/
          "CCR Refinery Glencore Canada Corporation"
        elsif smelter_name =~ /thailand/ && smelter_name =~ /smelting/ && smelter_name =~ /refining/
          "Thaisarco"
        elsif smelter_name =~ /ati\b/ && smelter.metal.downcase == 'tungsten'
          "Kennametal Huntsville"
        elsif smelter_name =~ /nusantara/
          smelter_name
        elsif smelter_name =~ /cookson/
          "Alpha"
        elsif smelter_name =~ /aurubis/
          "Aurubis AG"
        elsif smelter_name =~ /asahi|amagasaki/
          "Asahi Pretec Corporation"
        elsif smelter_name =~ /\bdowa\b/
          "Dowa"
        elsif smelter_name =~ /jx nippon|pan pacific copper/
          "JX Nippon Mining & Metals Co., Ltd."
        elsif smelter_name =~ /\bmitsui\b/
          "Mitsui Mining and Smelting Co., Ltd."
        elsif smelter_name =~ /\btanaka\b/
          "Tanaka Kikinzoku Kogyo K.K."
        elsif smelter_name =~ /tokuriki/
          "Tokuriki Honten Co., Ltd"
        elsif smelter_name =~ /central/ && smelter_name =~ /bank/ && smelter.facility_location_country.downcase =~ /philippines/
          "Bangko Sentral ng Pilipinas (Central Bank of the Philippines)"
        elsif smelter_name =~ /caridad/ && smelter.facility_location_country.downcase == 'mexico'
          "Caridad"
        elsif smelter_name =~ /\bsempsa\b/
          "SEMPSA Joyera Platera SA"
        elsif smelter_name =~ /\bmetalor\b/
          if smelter_name =~ /hong kong/
            "Metalor Technologies (Hong Kong) Ltd"
          elsif smelter_name =~ /singapore/
            "Metalor Technologies (Singapore) Pte. Ltd."
          elsif smelter_name =~ /\busa\b/ || smelter.facility_location_country.downcase =~ /united states/
            "Metalor USA Refining Corporation"
          else
            "Metalor Technologies SA"
          end
        elsif smelter_name =~ /\bsolar\b/
          "Solar Applied Materials Technology Corp."
        elsif smelter_name =~ /\bnavoi\b/
          "Navoi Mining and Metallurgical Combinat"
        elsif smelter.facility_location_country.downcase =~ /bolivia/
          if smelter_name =~ /vinto/ || smelter_name =~ /enaf/
            "EM Vinto"
          else
            smelter_name
          end
        elsif smelter_name.gsub(/\W/, '') =~ /yunnantin|ytcl/
          "Yunnan Tin Company, Ltd."
        elsif smelter_name =~ /china tin/
          "Liuzhou China Tin"
        elsif smelter_name.gsub(/\W/, '') =~ /zili/ && smelter.facility_location_country.downcase =~ /china/
          "Gejiu Zi-Li"
        elsif smelter_name =~ /kai/ && smelter_name =~ /unita|union/
          "Kai Unita Trade Limited Liability Company"
        elsif smelter_name =~ /msc/ && smelter.facility_location_country.downcase =~ /malaysia/
          "Malaysia Smelting Corporation (MSC)"
        elsif smelter_name =~ /minsur|funsur|amalgamated metal/ && smelter.facility_location_country.downcase =~ /peru/
          "Minsur"
        elsif smelter_name =~ /ulba/ && smelter.facility_location_country.downcase =~ /kazakhstan/
          "Ulba"
        elsif smelter_name =~ /china minmetal/
          "China Minmetals Nonferrous Metals Co Ltd"
        elsif smelter_name.gsub(/\W/, '') =~ /seadragon|grandsea/
          "Ganzhou Seadragon W & Mo Co., Ltd."
        elsif smelter_name.gsub(/\W/, '') =~ /rareearth/ && smelter.facility_location_country.downcase =~ /china/
          "Ganzhou Non-ferrous Metals Smelting Co., Ltd."
        elsif smelter_name.gsub(/\W/, '') =~ /almt/ && smelter.facility_location_country.downcase =~ /japan/
          "A.L.M.T. Corp."
        elsif smelter_name.gsub(/\W/, '') =~ /umicore/
          if smelter.facility_location_country.downcase =~ /brazil/
            "Umicore Brasil Ltda"
          elsif smelter.facility_location_country.downcase =~ /thailand/
            "Umicore Precious Metals Thailand"
          else
            "Umicore SA Business Unit Precious Metals Refining"
          end
        else
          smelter_name
        end
      end
      str1 = str1.split("\n").sort_by { |e| e.size }.last
      str1 = perform_strip_to_key_term ? strip_to_key_terms(str1) : str1
      str2 = perform_strip_to_key_term ? strip_to_key_terms(ref.standard_name) : ref.standard_name
      dist = jaro_winkler.getDistance(str1.downcase, str2.downcase)
      distances[dist] = [] if distances[dist].nil?
      distances[dist] << ref.standard_name
    end
    distances
  end

  def self.strip_to_key_terms(string)
    legal_words = %w(pt corp corporation co company ltd ltda limited llc spa sa ag gmbh inc pllc kg jsc pte industry ind)
    regexp = Regexp.new('\b' + (['\W'] + legal_words).join('\b|\b') + '\b')
    string.gsub(/[.,]/,'').downcase.gsub(regexp, '')
  end

end
