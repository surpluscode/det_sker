class RemoveCategoryRefFromEvents < ActiveRecord::Migration
  def change
    remove_reference :events, :category
  end
end
