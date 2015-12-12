class Booking < ActiveRecord::Base
  validates :date, :status, :customer_id, :table_id, presence: true

  enum status: [:pending, :rejected, :accepted]
end
