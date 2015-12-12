class RemoveCustomerIdFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :customer_id, :integer
  end
end
