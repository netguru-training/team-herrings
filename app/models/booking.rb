# == Schema Information
#
# Table name: bookings
#
#  id            :integer          not null, primary key
#  date          :datetime
#  status        :integer
#  reject_reason :string
#  customer_id   :integer
#  table_id      :integer
#  user_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Booking < ActiveRecord::Base
  validates :date, :status, :customer_id, :table_id, presence: true

  enum status: [:pending, :rejected, :accepted]
end
