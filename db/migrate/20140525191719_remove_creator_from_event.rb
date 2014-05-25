class RemoveCreatorFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :creator
  end
end
