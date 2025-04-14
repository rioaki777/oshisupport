class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :fanclub

  validates :status, presence: true, inclusion: { in: %w[active cancelled] }

  def active?
    status == "active"
  end

  def cancelled?
    status == "cancelled"
  end
end
