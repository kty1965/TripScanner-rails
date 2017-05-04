class ReviewSerializer < ActiveModel::Serializer
  belongs_to :writer, class_name: "User"
  belongs_to :owner, class_name: "User"

  # Need to split scope public/private redner attributes
  attributes :id, :view_scope, :rate, :content, :created_at, :updated_at
end
