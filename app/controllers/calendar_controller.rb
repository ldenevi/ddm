class CalendarController < ApplicationController
  def show
  end
  
  def datafeed
  
    #  Parameters: {"CalendarTitle"=>"asdfadf", "CalendarStartTime"=>"3/27/2013 08:00", "CalendarEndTime"=>"3/27/2013 12:00", "IsAllDayEvent"=>"0", "timezone"=>"-4", "method"=>"add"}

  
   render :json => list_calendar_by_range(params[:showdate], Time.now)
  end
  
  
private
  # Data for Javascript
  def list(params)
    date = Date.strptime(params[:showdate], "%D")
    #"showdate"=>"3/28/2013", "viewtype"=>"day", "timezone"=>"-4",
  end
  
  
  def list_calendar_by_range(start_date, end_date)
    data = {"events" => [],
            "issort" => true,
            "start" => Time.now,
            "end" => (Time.now + 1.week),
            "error" => nil}
  end
end
