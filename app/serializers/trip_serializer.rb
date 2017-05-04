class TripSerializer < ActiveModel::Serializer
  attributes :id, :address, :check_in, :check_out, :latitude, :longitude,
              :created_at, :updated_at

  belongs_to :owner, class_name: "User"
  has_many :reviews
end
