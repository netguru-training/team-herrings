class RemoveNameFromTables < ActiveRecord::Migration
  def change
    remove_column :tables, :name
  end
end
