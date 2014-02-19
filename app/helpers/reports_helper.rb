module ReportsHelper
  def report_filename(name)
    [current_user.organization.name, Time.now.strftime("%Y%m%d%H%M%S"), current_user.eponym, name].join('_-_').gsub(/[^\w,\s-\.]/, '').gsub(' ', '_')
  end

  def worksheet_header(worksheet, style)
    worksheet.add_image(:image_src => File.expand_path("../../public/images/logo.jpg", File.dirname(__FILE__)), :noSelect => true, :noMove => true) do |image|
     image.width  = 4
     image.height = 3

     image.start_at 0, 0
     image.end_at 2, 1
    end

    worksheet.add_row(["", "",[worksheet.name,
                              "%s: %s" % ["Co.".rjust(6, ' '), current_user.organization.full_name],
                              "%s: %s" % ["Date".rjust(6, ' '), Date.today],
                              "%s: %s" % ["Time".rjust(6, ' '), Time.now.strftime("%H:%M:%S")],
                              "%s: %s" % ["User".rjust(6, ' '), current_user.eponym]
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
end
