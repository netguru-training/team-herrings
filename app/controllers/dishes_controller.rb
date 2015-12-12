class DishesController < ApplicationController
  expose(:dish, attributes: :dish_params)
  expose(:dishes)

  def create
    if dish.save
      redirect_to dish_path(dish), notice: I18n.t('shared.created', resource: 'Dish')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if dish.save
      redirect_to dish_path(dish), notice: I18n.t('shared.updated', resource: 'Dish')
    else
      render :edit
    end
  end

  def destroy
    dish.destroy!
    redirect_to dishes_path, notice: I18n.t('shared.deleted', resource: 'Dish')
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :weight, :vat, :price)
  end
end
