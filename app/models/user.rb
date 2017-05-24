class User < ApplicationRecord
  require "open_uri_redirections"
  before_validation :handling_image_type

  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :trip_members, foreign_key: "member_id", dependent: :destroy
  has_many :joined_trips, through: :trip_members, source: :trip
  has_many :owned_trips, foreign_key: "owner_id", class_name: "Trip", dependent: :destroy

  has_many :owned_reviews, class_name: "Review", foreign_key: "owner_id"
  has_many :written_reviews, class_name: "Review", foreign_key: "writer_id"

  has_attached_file(:image,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: lambda { |image| ActionController::Base.helpers.asset_path('images/users/missing.png') })
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :gender, inclusion: { in: %w(male female) }, :allow_blank => true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = open(auth.info.image, allow_redirections: :all)
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def reviews
    owned_reviews | written_reviews
  end

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
