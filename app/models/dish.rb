class Dish < ActiveRecord::Base
  validates :name, :price, presence: true
  validates :vat, :weight, numericality: true
end
