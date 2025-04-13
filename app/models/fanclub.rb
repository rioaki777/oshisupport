class Fanclub < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy

  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :user_id, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true

  # 最新のContentを取得
  def latest_content
    contents.order(created_at: :desc).first
  end
end
