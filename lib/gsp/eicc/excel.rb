module GSP::Eicc::Excel
  autoload :Converters, File.join('gsp', 'eicc', 'excel', 'converters')



  class Declaration  
    attr_reader :revision, :instructions, :definitions, :declaration, :smelter_list, :standard_smelter_names, :checker, :product_list
    @worksheet_map = [:revision, :instructions, :definitions, :declaration, :smelter_list, :standard_smelter_names, :checker, :product_list]
    
    def initialize()
    end
    
    attr_accessor :output
    def system_convert_xls_to_csv
      # @output = system("ssconvert -S '/home/syreethus/Desktop/EiccTest/Alpha 20130627.xlsx' test/Alpha.csv")
      @output = system("ssconvert -S '/home/syreethus/Desktop/EiccTest/Monitor Appliance 2013 10 01.xls' test/Mon.csv")
      puts @output
    end
  end
end
