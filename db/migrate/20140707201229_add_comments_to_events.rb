class AddCommentsToEvents < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :hidden
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
    end
  end
end
