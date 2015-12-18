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

  before_validation :find_or_create_user, if: proc { password.present? }
  before_validation :generate_number, on: :create

  validates :password, confirmation: true, if: proc { password.present? }
  validates :date, :status, presence: true
  validates :reject_reason, presence: true, if: proc { rejected? }
  validates :number, presence: true, uniqueness: true, numericality: true, length: { is: 6 }
  belongs_to :table
  belongs_to :user
  has_one :customer
  accepts_nested_attributes_for :customer

  delegate :first_name, :last_name, :email, to: :customer, prefix: true, allow_nil: true
  delegate :name, :email, to: :user, prefix: true, allow_nil: true

  enum status: [:pending, :rejected, :accepted]

  scope :with_status, -> (status) { where(status: status) }

  def find_or_create_user
    name = "#{customer_first_name} #{customer_last_name}"
    _user = User.find_by email: customer_email
    if _user
      if _user.valid_password?(password)
        self.user = _user
      else
        self.errors.add(:base, 'Wrong password')
      end
    else
      _user = User.new name: name, email: customer_email, password: password, password_confirmation: password
      if _user.valid?
        self.user = _user
      else
        self.errors.add(:base, _user.errors.full_messages.join(', '))
      end
    end
  end

  private

  def generate_number
    loop do
      self.number = rand(999_999).to_s.center(6, rand(9).to_s)
      break unless self.class.exists?(number: number.to_s)
    end
  end
end
