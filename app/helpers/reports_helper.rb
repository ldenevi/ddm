module ReportsHelper
  def report_filename(name)
    [current_user.organization.name, Time.now.strftime("%Y%m%d%H%M%S"), current_user.eponym, name].join('_-_').gsub(/[^\w,\s-\.]/, '').gsub(' ', '_')
  end
end
