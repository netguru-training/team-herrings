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
end
