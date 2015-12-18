class RenameUniqueIdColumnToNumberInBookings < ActiveRecord::Migration
  def change
    rename_column :bookings, :unique_id, :number
  end
end
