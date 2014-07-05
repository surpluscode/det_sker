object @calendar
  attributes :filter_categories => :categories, :filter_locations => :locations
  child :days, object_root: false do
    attributes :date
    child :events, object_root: false do
      attributes :title, :short_description, :long_description, :cancelled, :price
      node(:start_time) {|event| format_starttime(event.start_time)}
      node(:end_time) {|event| format_starttime(event.end_time)}
      glue :user do
        attributes :username => :creator
        node(:creator_link) {|user| user_path(user)}
      end
    end

  end
