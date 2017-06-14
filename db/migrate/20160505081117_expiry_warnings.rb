class ExpiryWarnings < ActiveRecord::Migration
  def change
    add_column :event_series, :expiring_warning_sent, :boolean, default: false
    add_column :event_series, :expired_warning_sent, :boolean, default: false
  end
end
