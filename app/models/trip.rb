class Trip < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :reviews

  has_many :trip_members
  has_many :members, through: :trip_members, class_name: "User"

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

  # reverse_geocoded_by :latitude, :longitude
  # after_validation :reverse_geocode  # auto-fetch address
end
