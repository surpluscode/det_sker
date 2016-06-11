module DashboardHelper

  # don't create a link for the currently active sort type
  def dashboard_sort_link(type, sort)
    link = type == sort ? type.humanize : link_to(type.humanize, admin_dashboard_path(sort: type))
    "<li>#{link}</li>".html_safe
  end

  # JS for analytics - no need for ordinary users to load this stuff
  def admin_scripts
    content_for :special_scripts do
      concat(javascript_include_tag 'https://www.google.com/jsapi')
      concat(javascript_include_tag 'https://cdnjs.cloudflare.com/ajax/libs/chartkick/2.0.0/chartkick.min.js')
    end
  end
end