class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  expose_decorated(:bookings)
  expose_decorated(:booking, attributes: :booking_params)
  expose(:booking_owner) { booking.user }

  def new
    booking.build_customer
  end

  def create
    booking.user = current_user if user_signed_in?
    if booking.save
      sign_in(:user, booking_owner) if !user_signed_in? && booking.user.present?
      redirect_to creation_redirect_path, notice: t('shared.created', resource: 'Booking')
    else
      render :new
    end
  end

  def index
    self.bookings = current_user.bookings
  end

  private

  def booking_params
    params
        .require(:booking)
        .permit(:date, :password, :password_confirmation, :status,
                customer_attributes: [:email, :first_name, :last_name])
  end

  def creation_redirect_path
    user_signed_in? ? booking : root_path
  end
end
