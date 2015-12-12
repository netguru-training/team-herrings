class AddStatusToBookings < ActiveRecord::Migration
  def change
    change_column_default(:bookings, :status, 0)
  end
end
