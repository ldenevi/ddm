require 'prawn'
require "prawn/measurement_extensions"

class RoadmapController < ApplicationController
  include ReportsHelper

  def comprehensive_due_diligence
    review = Review.includes({:tasks => :comments}).where(:id => params[:id], :organization_id => current_user.organization.id).first

    storage_path = File.join(current_user.storage_path, "comprehensive_due_diligence_report_test.pdf")
    FileUtils.mkdir_p(current_user.storage_path)

    Prawn::Document.generate(storage_path) do

      # Top strip
      bounding_box([-0.5.in, 9.75.in], :width => 8.in, :height => 1.in) do
        # Header strip
        fill_color "A1693B"
        fill_rectangle [0, 1.75.in], 8.5.in, 1.in

        fill_color "FFCFA6"
        text "Report created: #{Time.now.to_formatted_s(:review_date)}", :align => :right, :size => 9
      end

      # Header
      bounding_box([0, 9.25.in], :width => 7.5.in, :height => 1.25.in) do
        fill_color "222222"
        text review.organization.name, :align => :center, :size => 14, :style => :bold
        move_down 20
        text review.name, :align => :left, :size => 12, :style => :bold
        text "Due: #{review.targeted_completion_at.to_formatted_s(:review_date)}", :align => :left, :size => 12, :style => :bold

        transparent(0.5) do
          image File.join(Rails.root, "public/images/logo.jpg"), :at => [5.5.in, 1.25.in], :scale => 0.66
        end
      end

      # Tasks
      review.tasks.each do |task|
        # Header
        sequence = make_cell(:content => "<font size='14'><b>#{task.sequence}</b></font>", :rowspan => 2, :valign => :center)
        header   = [sequence, "<font size='10'><b>Reviewer</b></font>", "<font size='10'><b>Start Date</b></font>", "<font size='10'><b>Completion Date</b></font>"]
        hdr_info = ["<font size='9'>%s</font>" % task.reviewer.eponym,
                    "<font size='9'>%s</font>" % ((task.start_at) ? task.start_at.to_formatted_s(:review_date) : 'Not started'),
                    "<font size='9'>%s</font>" % ((task.actual_completion_at) ? task.actual_completion_at.to_formatted_s(:review_date) : '')]

        # Instructions
        task_name = make_cell(:content => "<b>#{task.name}</b>", :align => :center)
        task_inst = make_cell(:content => "<font size='9'>%s</font>" % task.instructions.gsub('<li>', '- ').gsub('</li>', ""), :align => :left)

        # Comments
        comments = []
        task.comments.each do |comment|
          author = "<b>%s:</b>" % comment.author.eponym
          date   = "<font size='8'>%s</font>\n" % comment.created_at.to_formatted_s(:long)
          body   = "<font size='9'>%s</font>" % comment.body.gsub(/<\/.+>/, '').gsub(/<.+>/, '')
          attachments = "<font size='9'>Attachments: %s</font>" % comment.attachments.map { |a| "<color rgb='0000FF'><u><link href='%s'>%s</link></u></color>" % ["http://gsp-app.greenstatuspro.com/review/get_file/#{a.id}", a.filename] }.join(', ')
          comments += [[""], [[author, date, body, attachments].join("\n")]]
        end

        header_table = make_table([header, hdr_info], :column_widths => {0 => 30}, :width => 7.40.in, :position => :center, :cell_style => {:inline_format => true, :align => :center, :border_color => "CCCCCC", :background_color => "FAFAFA"})
        instructions_table = make_table([[task_name], [task_inst]], :width => 7.40.in, :position => :left, :cell_style => {:inline_format => true, :align => :left, :border_width => 0})
        comments_table = make_table(comments, :width => 7.40.in, :position => :left, :cell_style => {:inline_format => true, :align => :left, :border_width => 0})

        table([[header_table], [instructions_table], [comments_table]], :position => :center, :header => true, :width => 7.40.in, :cell_style => {:border_color => "CCCCCC"})
        move_down 15
      end

    end

    send_data File.read(storage_path), :filename => report_filename(File.basename(storage_path)), :type => 'application/pdf'
  end

end
