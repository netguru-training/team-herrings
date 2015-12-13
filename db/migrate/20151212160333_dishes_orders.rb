class DishesOrders < ActiveRecord::Migration
  def change
    create_table :dishes_orders do |t|
      t.references :order
      t.references :dish

      t.timestamps null: false
    end
  end
end
