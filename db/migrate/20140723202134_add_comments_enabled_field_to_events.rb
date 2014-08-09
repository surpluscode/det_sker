class AddCommentsEnabledFieldToEvents < ActiveRecord::Migration
  def change
    add_column :events, :comments_enabled, :boolean, default: false
  end
end
