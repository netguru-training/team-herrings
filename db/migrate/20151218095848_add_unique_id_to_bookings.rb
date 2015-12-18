class AddUniqueIdToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :unique_id, :string
    add_index :bookings, :unique_id
  end
end
