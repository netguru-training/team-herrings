class Admin::BookingsController < AdminController
  expose_decorated(:bookings) { Booking.includes(:customer, :user, :table).order('date desc') }
  expose(:booking, attributes: :booking_params)
  expose(:booking_tables) { Table.all }
  expose(:booking_customer) { Customer.new }

  def index
    self.bookings = bookings.with_status(params[:status]) if params[:status].present?
  end

  def create
    if booking.save
      redirect_to admin_booking_path(booking), notice: I18n.t('shared.created', resource: 'Booking')
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
    params.require(:booking).permit(:id, :table_id, :user_id, :date, :status, customer_attributes: [:first_name, :last_name, :email])
  end

  def booking_reject_params
    params.require(:booking).permit(:reject_reason).merge(status: 'rejected')
  end
end
