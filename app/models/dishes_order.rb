class DishesOrder < ActiveRecord::Base
  # before_validation :increment_count_if_found, on: [:create, :update]
  belongs_to :order
  belongs_to :dish

  validates :count, numericality: { greater_or_than: 0 }
  validates :order, :dish, presence: true

  # def increment_count_if_found
  #   DishesOrder.where(order: order, dish: dish).first_or_create.increment!(:count)
  # end
end
