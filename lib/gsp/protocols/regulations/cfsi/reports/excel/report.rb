class GSP::Protocols::Regulations::CFSI::Reports::Excel::Report < Object
  attr_accessor :validations_batch
  attr_accessor :worksheets
  attr_accessor :sorted_smelters

  LOGO_IMAGE_PATH = File.expand_path(File.join(Rails.root, "public/images/logo.jpg"), File.dirname(__FILE__))
  CHECKMARK_CHAR  = "\u2714"

  # Worksheet styles
  BRANDING_STYLE = {:sz => 9, :font_name => "Lucida Console", :alignment => {:horizontal => :left, :vertical => :top, :wrap_text => true}}
  HEADER_STYLE   = {:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true}}
  DATA_STYLE     = {:sz => 9, :alignment => {:horizontal => :left, :vertical => :top , :wrap_text => true}}

  def initialize(validations_batch)
    self.validations_batch = validations_batch
    self.worksheets = []
    self.sorted_smelters = []
    # Compile sorted source data
    self.validations_batch.latest_cmrt_validations.each do |val|
      next unless val.has_declaration?
      val.cmrt.declaration.mineral_smelters.each do |smelter|
        smelter.attributes.keys.each { |attr| smelter.send("#{attr}=", smelter.send(attr).to_s) }
        smelter.smelter_id = "Not Supplied" if smelter.smelter_id.to_s.empty? || smelter.smelter_id.to_s.strip.downcase == '#n/a'
        self.sorted_smelters << {:smelter => smelter, :cmrt_version => val.cmrt.version, :file_name => val.file_name, :declaration => val.cmrt.declaration}
      end
    end
    self.sorted_smelters = self.sorted_smelters.sort_by { |data| standard_sort.call(data[:smelter]) }
    self
  end

  def standard_sort
    # Report's default sort:
    #
    # 1. Sort by Gold, then Tin, Tantalum, Tungsten, empty field; all else alphanumerically sorted last
    # 2. Alphanumerically sort COUNTRY, all empty fields last
    # 3. Standard Smelter Name, all empty fields last
    Proc.new { |smelter| [(mineral_sort_order.index(smelter.metal.downcase) || 5),
                          (smelter.facility_location_country.empty? ? "ZZZZZZZ" + smelter.facility_location_country.downcase : smelter.facility_location_country.downcase),
                          (smelter.standard_smelter_name.empty? ? "ZZZZZZZ" + smelter.standard_smelter_name.downcase : smelter.standard_smelter_name.downcase)]  }
  end

  def mineral_sort_order
    ["gold", "tin", "tantalum", "tungsten", ""]
  end

  def is_valid_mineral?(value)
    mineral_sort_order.include?(value.to_s.downcase)
  end

  def does_mineral_match_v2_smelter_id?(smelter)
    return true if smelter.v2_smelter_id.to_s.empty?
    ref = {'1' => 'gold', '2' => 'tin', '3' => 'tantalum', '4' => 'tungsten'}
    ref[smelter.v2_smelter_id.strip[0]] == smelter.metal.strip.downcase
  end

  def valid_non_smelter_id_sort_order
    ["not listed", "not supplied", "unknown"]
  end

  def is_valid_smelter_id?(smelter_id)
    !(smelter_id.to_s.match(/^[1-4][A-Z]{3}[0-9]{3}$/) || smelter_id.to_s.match(/^CID/)).nil?
  end

  def is_valid_non_smelter_id?(non_smelter_id)
    valid_non_smelter_id_sort_order.include? non_smelter_id.to_s.downcase
  end

  def is_valid_smelter_name?(smelter_name)
    smelter_name.downcase.split('').uniq.size > 1 && smelter_name.size > 2
  end

  def worksheet_header(worksheet, style)
    worksheet.add_image(:image_src => LOGO_IMAGE_PATH, :noSelect => true, :noMove => true) do |image|
     image.width  = 4
     image.height = 3

     image.start_at 0, 0
     image.end_at 2, 1
    end

    worksheet.add_row(["", "",[worksheet.name,
                              "%s: %s" % ["Co.".rjust(6, ' '), validations_batch.user.organization.name],
                              "%s: %s" % ["Date".rjust(6, ' '), Date.today],
                              "%s: %s" % ["Time".rjust(6, ' '), Time.now.strftime("%H:%M:%S")],
                              "%s: %s" % ["User".rjust(6, ' '), validations_batch.user.eponym]
                              ].join("\n")], :style => style).height = 65.0

    worksheet.merge_cells "A1:B1"
    worksheet.merge_cells "C1:E1"

    # Freeze pane over data rows
    worksheet.sheet_view.pane do |pane|
      pane.top_left_cell = "A3"
      pane.state = :frozen_split
      pane.y_split = 2
      pane.x_split = 0
      pane.active_pane = :bottom_right
    end
  end

  def to_excel
    Axlsx::Package.new do |p|
      branding_style = nil
      header_style   = nil
      data_style     = nil
      p.workbook.styles do |styles|
        branding_style = styles.add_style(:sz => 9, :font_name => "Lucida Console", :alignment => {:horizontal => :left, :vertical => :top, :wrap_text => true})
        header_style   = styles.add_style(:b => true, :sz => 10, :alignment => {:horizontal => :center, :vertical => :center , :wrap_text => true})
        data_style     = styles.add_style(:sz => 9, :alignment => {:horizontal => :left, :vertical => :top , :wrap_text => true})
      end

      worksheets.each do |worksheet_meta|
        p.workbook.add_worksheet(:name => worksheet_meta[:name]) do |sheet|
          worksheet_header(sheet, branding_style)
          sheet.add_row(["#"] + worksheet_meta[:header].collect { |h| h[:name] }, :style => header_style).height = 35.0
          friendly_index = 1
          worksheet_meta[:data].each do |row|
            sheet.add_row([friendly_index] + row, :style => data_style, :types => :string, :widths => [6] + worksheet_meta[:header].collect { |h| h[:column_width]})
            friendly_index += 1
          end
        end
      end
    end
  end

  def to_s
    {:@validations_batch => self.validations_batch.to_s, :@worksheets => self.worksheets.to_s}
  end
end
