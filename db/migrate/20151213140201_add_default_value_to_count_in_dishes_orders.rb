class AddDefaultValueToCountInDishesOrders < ActiveRecord::Migration
  def change
    change_column :dishes_orders, :count, :integer, default: 0
  end
end
