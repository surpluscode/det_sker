object @calendar
  attributes :filter_categories => :categories, :filter_locations => :locations
  child :days do
    attributes :date, :filter_categories
    child :events do
      attributes :title, :start_time, :end_time, :short_description, :long_description, :cancelled, :price
    end

  end
