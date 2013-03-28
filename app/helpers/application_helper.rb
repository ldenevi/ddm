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
end
