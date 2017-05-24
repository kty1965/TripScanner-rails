class TripSerializer < ActiveModel::Serializer
  attributes :id, :address, :check_in, :check_out, :latitude, :longitude,
              :created_at, :updated_at, :city, :country, :content,
              :image_thumb, :image_medium, :image_original

  belongs_to :owner, class_name: "User"
  has_many :reviews
  has_many :members, through: :trip_members, class_name: "User"
end
