class OrdersController < ApplicationController
  before_action :authenticate_admin!


  expose(:tables)
  expose(:dishes)
  expose(:users) { User.where(role: 'waiter') }
  expose(:order, attributes: :order_params)
  expose(:orders)
  expose(:statuses) { Order.statuses.keys }

  def create
    if order.save
      redirect_to order_path(order), notice: I18n.t('shared.created', resource: 'Dish')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if order.save
      redirect_to order_path(order), notice: I18n.t('shared.updated', resource: 'Dish')
    else
      render :edit
    end
  end

  def destroy
    order.destroy!
    redirect_to orders_path, notice: I18n.t('shared.deleted', resource: 'Dish')
  end

  private

  def order_params
    params.require(:order).permit(:table_id, :user_id, :status)
  end
end
