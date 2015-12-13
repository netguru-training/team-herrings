class Order < ActiveRecord::Base
  belongs_to :table
  belongs_to :user
  has_and_belongs_to_many :dishs

  validates :table, :user, presence:true
  validate :verify_user_is_waiter

  private

  def verify_user_is_waiter
    errors.add(:user, 'User has to be a waiter') unless user.try(:has_role?, 'waiter')
  end
end
