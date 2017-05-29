class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :school, :job, :locale, :country,
    :image_thumb, :image_medium, :image_original, :introduction,
    :written_reviews_count, :written_reviews_rate
end
