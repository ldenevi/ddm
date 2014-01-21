require 'axlsx'

class GSP::Reports::ExcelReport < Axlsx::Package

  attr_reader :data, :user, :organization, :header

  def initialize
  end

end
