class RenameTablesTypeColumnToLocation < ActiveRecord::Migration
  def change
    rename_column :tables, :type, :location
  end
end
