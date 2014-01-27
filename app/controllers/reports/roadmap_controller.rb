class Reports::RoadmapController < ApplicationController
  include ReportsHelper

  def comprehensive_due_diligence

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
