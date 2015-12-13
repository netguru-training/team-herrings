# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :string           default("guest"), not null
#

class User < ActiveRecord::Base

  ROLES = [
      ADMIN_ROLE = 'admin',
      WAITER_ROLE = 'waiter',
      GUEST_ROLE = 'guest'
  ]

  validates :name, presence: true, length: { minimum: 3, allow_blank: true }
  validates :role, inclusion: { in: ROLES }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  def admin?
    role == ADMIN_ROLE
  end

  def waiter?
    (role == ADMIN_ROLE) || (role == WAITER_ROLE)
  end

  def has_role?(_role)
    role == _role
  end
end
