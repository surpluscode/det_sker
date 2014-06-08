class AddLocationReferenceToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :location, :text
    add_reference :events, :location, index: true
  end
end
