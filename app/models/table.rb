class Table < ActiveRecord::Base
  validates :places, :type, presence: true
  enum type: [:indoor, :outdoor]
  validates :type, inclusion: { in: Table.types.keys }
end
