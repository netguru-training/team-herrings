# == Schema Information
#
# Table name: dishes
#
#  id         :integer          not null, primary key
#  name       :string
#  vat        :integer
#  weight     :integer
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dish < ActiveRecord::Base
  validates :name, :price, presence: true

  has_and_belongs_to_many :orders

  def net_price
    (price - (price / (vat + 100) * vat)).round(2)
  end
end
