module DashboardHelper

  # don't create a link for the currently active sort type
  def dashboard_sort_link(type, sort)
    link = type == sort ? type.humanize : link_to(type.humanize, admin_dashboard_path(sort: type))
    "<li>#{link}</li>".html_safe
  end
end