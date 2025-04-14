class Content < ApplicationRecord
  belongs_to :fanclub

  has_one_attached :image

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true
end
