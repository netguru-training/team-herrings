class DishesController < ApplicationController
  expose_decorated(:dishes)
  expose_decorated(:dish)

  def show
  end
end
