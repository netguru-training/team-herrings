class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.int :vat
      t.float :price

      t.timestamps null: false
    end
  end
end
