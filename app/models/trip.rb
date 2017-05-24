class Trip < ApplicationRecord
  before_validation :handling_image_type

  belongs_to :owner, class_name: "User"
  has_many :reviews, dependent: :destroy

  has_many :trip_members, dependent: :destroy
  has_many :members, through: :trip_members, class_name: "User"

  has_attached_file(:image,
                    styles: {
                      medium: "640x640>",
                      thumb: "320x320>"
                    })
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

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

  def image_thumb
    ActionController::Base.helpers.asset_path(image.url(:thumb))
  end
  def image_medium
    ActionController::Base.helpers.asset_path(image.url(:medium))
  end
  def image_original
    ActionController::Base.helpers.asset_path(image.url)
  end

  def handling_image_type
    unless self.image.is_a? ActionDispatch::Http::UploadedFile
      temp_image = Paperclip.io_adapters.for(self.image)
      temp_image.original_filename = "base_64.png"
      self.image = temp_image
    end
  end
end
