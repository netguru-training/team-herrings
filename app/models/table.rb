class Table < ActiveRecord::Base
  validates :name, :places, :type, presence: true
  enum type: [:indoor, :outdoor]
  validates :type, inclusion: { in: Table.types.keys }
end
