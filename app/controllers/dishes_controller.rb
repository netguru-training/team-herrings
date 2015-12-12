class DishesController < ApplicationController
  expose(:dish, attributes: :dish_params)
  expose(:dishes)

  def create
    if dish.save
      redirect_to dish_path(dish)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if dish.save
      redirect_to dish_path(dish)
    else
      render :edit
    end
  end

  def destroy
    dish.destroy!
    redirect_to dishes_path
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :weight, :vat, :price)
  end
end
