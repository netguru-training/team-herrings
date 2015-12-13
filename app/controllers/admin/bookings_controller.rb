class Admin::BookingsController < AdminController
  before_action :authenticate_user!, only: [:show, :edit, :index, :accept, :reject]

  expose_decorated(:bookings) { fetch_bookings }
  expose(:booking, attributes: :booking_params)
  expose(:booking_tables) { Table.all }
  expose(:booking_customer) { Customer.new }

  def new
    self.booking = Booking.new
    booking.build_customer
  end

  def create
    self.booking = Booking.new(booking_params)
    if booking.save
      sign_in(:user, User.find(booking.user_id))
      user_redirector
    else
      render :new
    end
  end

  def update
    if booking.save
      redirect_to admin_booking_path(booking), notice: I18n.t('shared.updated', resource: 'Booking')
    else
      render :edit
    end
  end

  def accept
    self.booking = Booking.find(params[:id])

    if booking.accepted!
      BookingMailer.booking_accepted_email(booking).deliver_now
      redirect_to admin_bookings_path, notice: I18n.t('booking.accepted', date: booking.date)
    else
      render :show
    end
  end

  def reject
    self.booking = Booking.find(params[:id])
    if booking.update_attributes(booking_reject_params)
      BookingMailer.booking_rejected_email(booking).deliver_now
      redirect_to admin_bookings_path, notice: I18n.t('booking.rejected', date: booking.date)
    else
      render :edit
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :status, :password, :password_confirmation, customer_attributes: [:first_name, :last_name, :email])
  end

  def user_redirector
    if current_user && current_user.admin?
      redirect_to admin_booking_path(booking), notice: I18n.t('shared.created', resource: 'Booking')
    else
      redirect_to admin_bookings_path, notice: I18n.t('booking.created')
    end
  end

  def booking_reject_params
    params.require(:booking).permit(:reject_reason).merge(status: 'rejected')
  end

  def fetch_bookings
      _bookings = current_user.admin? ? Booking.all.includes(:customer) : current_user.bookings
      params[:status] == 'pending' ? _bookings.pending.order('date desc') : _bookings.order('date asc')
  end
end
