class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_one_attached :profile_image
  validate :acceptable_image

  has_one :fanclub, dependent: :destroy
  has_many :contents, through: :fanclub

  has_many :subscriptions, dependent: :destroy
  has_many :subscribed_fanclubs, through: :subscriptions, source: :fanclub

  def acceptable_image
    return unless profile_image.attached?

    unless profile_image.blob.content_type.start_with?("image/")
      errors.add(:profile_image, "は画像ファイルを添付してください")
    end

    if profile_image.blob.byte_size > 5.megabytes
      errors.add(:profile_image, "は5MB以下のサイズにしてください")
    end
  end
end
