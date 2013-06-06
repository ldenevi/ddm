class ReportsController < ApplicationController
  layout 'print', :only => 'generate_comprehensive'

  def list
  end

  def view
  end
  
  def comprehensive
    @reviews = (current_user) ? current_user.organization.reviews.sort_by(&:targeted_completion_at) : []
  end
  
  def generate_comprehensive
    @review = Review.includes({:tasks => :comments}).where(:id => params[:id]).first
  end
  
  
  # Dashboard graphs
  def review_status
    @graph_image_url = Gchart.pie(:size => '400x400', 
                                  :title => "Reviews",
                                  :bg => 'efefef',
                                  :legend => ['Completed', 'Not Completed'],
                                  :data => [4, 6])
  end
  
  def task_status
  end
  
  def task_findings
  end
end
