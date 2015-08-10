class UpdateEventSeries < ActiveRecord::Migration
  def change
  	add_column :event_series, :days, :string
  	add_column :event_series, :expiry, :datetime
  end
end
