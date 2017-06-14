class AddPublishedFieldToEvents < ActiveRecord::Migration
  def change
    add_column :events, :published, :boolean, default: true
    add_column :event_series, :published, :boolean, default: true
  end
end
