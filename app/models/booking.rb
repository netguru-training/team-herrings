# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer
#  reject_reason :string
#  table_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Booking < ActiveRecord::Base
  before_validation { |booking| booking.status = :pending }
  validates :date, :status, presence: true
  belongs_to :table
  has_one :customer
  accepts_nested_attributes_for :customer

  enum st: [:pending, :rejected, :accepted]
end
