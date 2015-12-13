class AddCountToDishesOrders < ActiveRecord::Migration
  def change
    add_column :dishes_orders, :count, :integer
  end
end
