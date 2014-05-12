class AddLongDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :long_description, :text
    rename_column :events, :description, :short_description
  end
end
