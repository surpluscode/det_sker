object @calendar
  attributes :filter_categories => :categories, :filter_locations => :locations
  child :days, object_root: false do
    attributes :date
    child :events, object_root: false do
      attributes :title, :start_time, :end_time, :short_description, :long_description, :cancelled, :price
      glue :user do
        attributes :username => :creator
        node(:creator_link) {|user| user_path(user)}
      end
    end

  end
