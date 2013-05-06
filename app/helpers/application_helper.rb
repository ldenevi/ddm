module ApplicationHelper
  def active_feature(menu_item)
    if (params[:controller].match(/^admin/).to_s == menu_item)
      'top-menu-link-active'
    elsif params[:controller] == menu_item
      'top-menu-link-active'
    else
      ''
    end
  end
  
  def formatted_posted_at(datetime)
    if datetime > (Time.now - 1.week)
      "Posted %s ago" % time_ago_in_words(datetime)
    else
      datetime.strftime("%-m/%d/%Y %l:%M %P")
    end
  end
  
  
end
