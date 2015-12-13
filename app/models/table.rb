class Table < ActiveRecord::Base
  validates :places, :location, presence: true
  enum location: [:indoor, :outdoor]
  validates :location, inclusion: { in: Table.locations.keys }

  def to_s
    "#{id} with #{places} places"
  end
end
