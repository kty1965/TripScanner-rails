class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image_thumb, :image_medium, :image_original
end
