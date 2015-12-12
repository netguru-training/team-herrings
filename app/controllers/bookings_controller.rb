class BookingsController < ApplicationController
  expose(:bookings)
  expose(:booking, attributes: :booking_params)
  expose(:booking_tables) { Table.all }
  expose(:booking_customer) { Customer.new }

  def new
    booking.build_customer
  end

  def create
    if booking.save
      redirect_to booking_path(booking), notice: I18n.t('shared.created', resource: 'Booking')
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :status, customer_attributes: [:first_name, :last_name, :email])
  end
end
