class Trip < ApplicationRecord
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
  validates :content, presence: true

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

  def image_data=(value)
    return unless value
    tokens = value.split(";")
    content_type = tokens[0].split(":")[1]
    filename = tokens[1].split(":")[1]
    value = tokens[2].split(",")[1]
    StringIO.open(Base64.decode64(value)) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.content_type = content_type
      data.original_filename = filename
      self.image = data
    end
  end
end
