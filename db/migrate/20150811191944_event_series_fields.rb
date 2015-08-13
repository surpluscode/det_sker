class EventSeriesFields < ActiveRecord::Migration
  def change
  	change_column :event_series, :expiry, :date
  	add_column :event_series, :start_date, :date
  	add_column :event_series, :start_time, :time
  	add_column :event_series, :end_time, :time
  end
end
