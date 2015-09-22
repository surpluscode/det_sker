class AddIndexToPosts < ActiveRecord::Migration
  def change
  	add_index :posts, :featured
  end
end
