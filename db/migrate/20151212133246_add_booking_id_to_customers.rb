class AddBookingIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :booking_id, :integer
  end
end
