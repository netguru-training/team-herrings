class AddDefaultValueToCountInDishesOrders < ActiveRecord::Migration
  def change
    change_column :dishes_orders, :count, :integer, default: 1
  end
end
