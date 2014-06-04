class RemoveCategoryFieldFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :category, :string
  end
end
