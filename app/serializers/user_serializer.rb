class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :school, :job, :locale, :country,
    :image_thumb, :image_medium, :image_original, :introduction
end
