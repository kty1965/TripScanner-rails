class Trip < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :reviews, dependent: :destroy

  has_many :trip_members, dependent: :destroy
  has_many :members, through: :trip_members, class_name: "User"

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.country = geo.country
      obj.longitude = geo.longitude
      obj.latitude = geo.latitude
    end
  end
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address
end
