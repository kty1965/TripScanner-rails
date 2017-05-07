class AddGeocodeColumnsToTrip < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :city, :string
    add_column :trips, :country, :string
  end
end
