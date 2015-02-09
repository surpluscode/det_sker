class AddPictureField < ActiveRecord::Migration
  def change
    add_attachment :events, :picture
  end
end
