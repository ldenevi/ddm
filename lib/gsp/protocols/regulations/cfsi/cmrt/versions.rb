# http://stackoverflow.com/questions/653157/a-better-similarity-ranking-algorithm-for-variable-length-strings

require 'fuzzystringmatch'

module GSP::Protocols::Regulations::CFSI::CMRT::Versions
  VERSION_HEADER_DATA_DIRPATH = File.join('lib', 'gsp', 'protocols', 'regulations', 'cfsi', 'cmrt', 'versions')

  VERSIONS = {"1.00" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "1.00.worksheet.0.txt")),
              "2.00" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "2.00.worksheet.0.txt")),
              "2.01" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "2.01.worksheet.0.txt")),
              "2.02" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "2.02.worksheet.0.txt")),
              "2.03" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "2.03.worksheet.0.txt")),
              "2.03a" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "2.03a.worksheet.0.txt")),
              "3.00" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "3.00.worksheet.0.txt")),
              "3.01" => File.read(File.join(VERSION_HEADER_DATA_DIRPATH, "3.01.worksheet.0.txt"))}

  def get_version(worksheet_0)
    get_similarity_ratings(worksheet_0).sort { |a, b| b[1] <=> a[1] }.first[0]
  end

  def get_similarity_ratings(comparison_string)
    similarities = []
    VERSIONS.each do |cmrt_version, version_data|
      similarities << [cmrt_version, string_similarity(version_data, comparison_string)]
    end
    similarities
  end

  def string_similarity(str1, str2)
    pairs1 = (0..str1.length - 2).collect { |i| str1[i,2] }.reject { |pair| pair.include? " " }
    pairs2 = (0..str2.length - 2).collect { |i| str2[i,2] }.reject { |pair| pair.include? " " }
    union  = pairs1.size + pairs2.size
    intersection = 0

    pairs1.each do |p1|
      0.upto(pairs2.size-1) do |i|
        if p1 == pairs2[i]
          intersection += 1
          pairs2.slice!(i)
          break
        end
      end
    end

    (2.0 * intersection) / union
  end

  def get_jarow_distances(comparison_string)
    distances = []
    jarow = FuzzyStringMatch::JaroWinkler.create(:native)
    VERSIONS.each do |cmrt_version, version_data|
      distances << [cmrt_version, jarow.getDistance(version_data, comparison_string)]
    end
    distances
  end

end
