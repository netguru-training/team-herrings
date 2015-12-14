# == Schema Information
#
# Table name: tables
#
#  id         :integer          not null, primary key
#  places     :integer
#  location   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Table < ActiveRecord::Base
  validates :places, :location, presence: true
  enum location: [:indoor, :outdoor]
  validates :location, inclusion: { in: Table.locations.keys }

  def to_s
    "#{id} with #{places} places"
  end
end
