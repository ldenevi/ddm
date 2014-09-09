class Roadmap::LogosController < ApplicationController
  def get
    @agency = Agency.find(params[:id])
    send_data @agency.logo, :type => "image/png", :disposition => "inline"
  end
end
