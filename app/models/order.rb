class Order < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
  has_many :dishes_orders

  enum statuses: [:created, :delivered, :paid]

  validates :table, :user, :status, presence:true
  validates :status, inclusion: { in: Order.statuses.keys }
  validate :verify_user_is_waiter

  private

  def verify_user_is_waiter
    errors.add(:user, 'User has to be a waiter') unless user.try(:has_role?, 'waiter')
  end
end
