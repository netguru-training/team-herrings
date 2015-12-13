class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status
      t.references :table
      t.references :user

      t.timestamps null: false
    end
  end
end
