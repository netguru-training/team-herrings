class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.int :vat
      t.int :weight
      t.float :price

      t.timestamps null: false
    end
  end
end
