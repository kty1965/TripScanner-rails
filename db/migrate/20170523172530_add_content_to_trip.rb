class AddContentToTrip < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :content, :text
  end
end
