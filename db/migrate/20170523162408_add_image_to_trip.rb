class AddImageToTrip < ActiveRecord::Migration[5.0]
  def up
    add_attachment :trips, :image
  end

  def down
    remove_attachment :trips, :image
  end
end
