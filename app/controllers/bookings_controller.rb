class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :index]

  expose_decorated(:bookings) { fetch_bookings }
  expose(:booking, attributes: :booking_params)
  expose(:booking_tables) { Table.all }
  expose(:booking_customer) { Customer.new }

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
      redirect_to booking_path(booking), notice: I18n.t('shared.updated', resource: 'Booking')
    else
      render :edit
    end
  end

  def accept
    self.booking = Booking.find(params[:id])

    if booking.accepted!
      BookingMailer.booking_accepted_email(booking).deliver_now
      redirect_to bookings_path, notice: I18n.t('booking.accepted', date: booking.date)
    else
      render :show
    end
  end

  def reject
    if booking.rejected! && booking.update_attributes(booking_reject_params)
      BookingMailer.booking_rejected_email(booking).deliver_now
      redirect_to bookings_path, notice: I18n.t('booking.rejected', date: booking.date)
    else
      render :show
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :status, customer_attributes: [:first_name, :last_name, :email])
  end

  def booking_reject_params
    params.require(:booking).permit(:reject_reason)
  end

  def fetch_bookings
    params[:status] == 'pending' ? Booking.pending.order('date desc') : Booking.order('date asc')
  end
end
