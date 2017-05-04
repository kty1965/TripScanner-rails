class TripMember < ApplicationRecord
  belongs_to :member, class_name: "User"
  belongs_to :trip
end
