class CalendarController < ApplicationController
  def show
  end
  
  def datafeed
  
    #  Parameters: {"CalendarTitle"=>"asdfadf", "CalendarStartTime"=>"3/27/2013 08:00", "CalendarEndTime"=>"3/27/2013 12:00", "IsAllDayEvent"=>"0", "timezone"=>"-4", "method"=>"add"}

   if params[:method] == 'list'
     render :json => list_calendar_by_range(params[:showdate], Time.now)
   else
      render :none
   end
  end
  
  
private
  # Data for Javascript
  def list(params)
    date = Date.strptime(params[:showdate], "%D")
    #"showdate"=>"3/28/2013", "viewtype"=>"day", "timezone"=>"-4",
  end
  
  def jsDate(time)
    time.strftime("%m/%d/%Y %H:%M")
  end
  
  def tasks_to_events
    current_user.active_tasks.map do |task|
      [
        task.id,
        ("[%s] %s (%s)" % [task.sequence, task.name, task.review.name]),
        jsDate(task.start_at),
        jsDate(task.expected_completion_at),
        1,
        1,
        0,
        1,
        0,
        "",
        ""
      ]
    end
  end
  
  
  def list_calendar_by_range(start_date, end_date)
    events = [[1,
             "Leo rules",
              jsDate(Time.now),
              jsDate(Time.now + 1.hour),
              1,
              0,
              0,
              1,
              0,
              "Castle Snow",
              'What'],
              [2,
             "Another",
              jsDate(Time.now),
              jsDate(Time.now + 1.hour),
              1,
              0,
              0,
              2,
              0,
              "Castle Snow",
              '']
              ]
  
    data = {"events" => tasks_to_events,
            "issort" => true,
            "start" => jsDate(Time.now),
            "end" => jsDate(Time.now + 1.week),
            "error" => nil}
  end
end
