class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.integer :vat
      t.integer :weight
      t.float :price

      t.timestamps null: false
    end
  end
end
