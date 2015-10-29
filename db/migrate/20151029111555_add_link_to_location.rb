class AddLinkToLocation < ActiveRecord::Migration
  def change
  	add_column :locations, :link, :string
  end
end
