class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  expose_decorated(:bookings)
  expose(:booking, attributes: :booking_params)
  expose(:booking_owner) { booking.user }

  def new
    booking.build_customer
  end

  def create
    if booking.save
      sign_in(:user, booking_owner) if !user_signed_in? && booking.user.present?
      flash[:notice] = t('shared.created', resource: 'Booking')
      redirect_to creation_redirect_path
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
