class TripMember < ApplicationRecord
  belongs_to :member, class_name: "User"
  belongs_to :trip

  after_create :create_pending_reviews
  before_destroy :destroy_reviews

  def create_pending_reviews
    pending_review_user_ids = trip.join_user_ids - [member.id]
    pending_review_user_ids.each do |user_id|
      Review.create(owner_id: member.id, writer_id: user_id, trip: trip, view_scope: "public")
      Review.create(owner_id: user_id, writer_id: member.id, trip: trip, view_scope: "public")
    end
  end

  def destroy_reviews
    pending_review_user_ids = trip.join_user_ids - [member.id]
    pending_review_user_ids.each do |user_id|
      Review.find_by(owner_id: member.id, writer_id: user_id, trip: trip, view_scope: "public").destroy rescue nil
      Review.find_by(owner_id: user_id, writer_id: member.id, trip: trip, view_scope: "public").destroy rescue nil
    end
  end
end
