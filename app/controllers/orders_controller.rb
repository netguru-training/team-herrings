class OrdersController < ApplicationController
  before_action :authenticate_admin!


  expose(:tables)
  expose(:dishes)
  expose(:dish) { Dish.find(params[:dish_id]) }
  expose(:users) { User.where(role: 'waiter') }
  expose(:order, attributes: :order_params)
  expose(:orders)
  expose(:statuses) { Order.statuses.keys }

  def create
    if order.save
      redirect_to order_path(order), notice: I18n.t('shared.created', resource: 'Order')
    else
      render :new
    end
  end

  def edit
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "orders",   # Excluding ".pdf" extension.
        :layout => 'pdf' # uses views/layouts/pdf.haml
      end
    end
  end

  def update
    if order.save
      redirect_to order_path(order), notice: I18n.t('shared.updated', resource: 'Order')
    else
      render :edit
    end
  end

  def destroy
    order.destroy!
    redirect_to orders_path, notice: I18n.t('shared.deleted', resource: 'Order')
  end

  def add_dish
    self.order = Order.find(params[:id])
    if order.dishes << dish
      redirect_to order_path(order), notice: I18n.t('shared.updated', resource: 'Dish')
    else
      render :show
    end
  end

  def change_dish_count
  end

  private

  def order_params
    params.require(:order).permit(:table_id, :user_id, :status)
  end
end
