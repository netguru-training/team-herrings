class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :index]
  expose(:bookings)
  expose(:booking, attributes: :booking_params)
  expose(:booking_tables) { Table.all }
  expose(:booking_customer) { Customer.new }
  expose_decorated(:bookings)

  def new
    booking.build_customer
  end

  def create
    if booking.save
      redirect_to root_path, notice: I18n.t('shared.created', resource: 'Booking')
    else
      render :new
    end
  end

  def update
    if booking.save
      redirect_to booking_path(booking), notice: I18n.t('shared.updated', resource: 'Student')
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :status, customer_attributes: [:first_name, :last_name, :email])
  end
end
