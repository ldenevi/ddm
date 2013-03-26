class ReportsController < ApplicationController
  layout 'print', :only => 'generate_comprehensive'

  def list
  end

  def view
  end
  
  def comprehensive
    @reviews = (current_user) ? current_user.organization.reviews : []
  end
  
  def generate_comprehensive
    @review = Review.includes({:tasks => :comments}).where(:id => params[:id]).first
  end
end
