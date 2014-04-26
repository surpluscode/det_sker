class AddMissingFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :price, :string
    add_column :events, :cancelled, :boolean
  end
end
