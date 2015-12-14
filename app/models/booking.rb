# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer          default(0)
#  reject_reason :string
#  table_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Booking < ActiveRecord::Base
  
  attr_accessor :password, :password_confirmation
  
  before_validation :find_or_create_user, :if => proc { password.present? }
  
  validates :password, :confirmation => true, :if => proc { password.present? }
  validates :date, :status, presence: true
  belongs_to :table
  belongs_to :user
  has_one :customer
  accepts_nested_attributes_for :customer

  delegate :first_name, :last_name, :email, :to => :customer, :prefix => true, :allow_nil => true
  delegate :name, :to => :user, :prefix => true, :allow_nil => true

  scope :pending, -> { where(status: statuses[:pending]) }

  enum status: [:pending, :rejected, :accepted]
  
  def find_or_create_user
    name = "#{first_name} #{last_name}"
    _user = User.find_by email: email
    if _user 
      if _user.valid_password?(password)
        self.user = _user
      else
        self.errors.add(:base, 'Wrong password')
      end
    else
      _user = User.new name: name, email: email, password: password, password_confirmation: password
      if _user.valid?
        self.user = _user
      else
        self.errors.add(:base, _user.errors.full_messages.join(', '))
      end
    end
  end
end
