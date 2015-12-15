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
  validates :name, :price, :vat, :weight, presence: true

  has_many :dishes_orders
  belongs_to :category

  def net_price
    (price - (price / (vat + 100) * vat)).round(2)
  end
end
