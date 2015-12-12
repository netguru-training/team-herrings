class Dish < ActiveRecord::Base
  validates_presence_of :name, :price
  validates_numericality_of :vat
end
