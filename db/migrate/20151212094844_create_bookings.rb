class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.datetime :date
      t.integer :status
      t.string :reject_reason
      t.integer :customer_id
      t.integer :table_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
