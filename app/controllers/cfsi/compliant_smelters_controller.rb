class Cfsi::CompliantSmeltersController < ApplicationController
  def list
    @confirmed_smelters = Cfsi::ConfirmedSmelter.order(:mineral).all
  end

  def update
    data = params[:csv].read.force_encoding("windows-1251").encode("UTF-8")
    csv = CSV.new(data).to_a
    if csv.size > 1
      Cfsi::ConfirmedSmelter.destroy_all
      csv.each_with_index do |row, index|
        confirmed_smelter = Cfsi::ConfirmedSmelter.create :mineral => row[0],
                                                            :v3_smelter_id => row[1],
                                                            :name => row[2],
                                                            :locations => row[3].to_s.split(",").each(&:strip),
                                                            :status => row[4],
                                                            :source => "CFSI",
                                                            :invalid_at => Time.now + 3.months
        unless confirmed_smelter.valid?
          flash[:error] = "Invalid data on row ##{index + 1} in '#{params[:csv].original_filename}'"
          break
        end
      end
    else
      flash[:error] = "CSV file is empty"
    end
    redirect_to :action => :list
  end
end
