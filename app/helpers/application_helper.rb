module ApplicationHelper
  def active_feature(menu_item)
    'top-menu-link-active' if params[:controller] == menu_item;
  end
end
