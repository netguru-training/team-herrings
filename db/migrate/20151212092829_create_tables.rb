class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :places
      t.integer :type

      t.timestamps null: false
    end
  end
end
