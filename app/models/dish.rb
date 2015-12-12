class Dish < ActiveRecord::Base
  validates :name, :price, presence: true
  validates :vat, numericality: true
end
