module Admin
  class BookingsController < AdminController
    rescue_from ActiveRecord::RecordInvalid, with: :reject_reason_not_present
    before_action :authenticate_admin!

    expose_decorated(:bookings) { Booking.includes(:customer, :user, :table).order('date desc') }
    expose(:booking, attributes: :booking_params)
    expose(:booking_by_id) { Booking.find(params[:id]) }
    expose(:booking_tables) { Table.all }
    expose(:booking_customer) { Customer.new }

    def index
      return unless params[:status].present?
      self.bookings = bookings.with_status(params[:status])
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
      if booking_by_id.accepted!
        BookingMailer.booking_accepted_email(booking_by_id).deliver_now
        redirect_to admin_bookings_path, notice: I18n.t('booking.accepted', date: booking_by_id.date)
      else
        render :show
      end
    end

    def reject
      booking_by_id.reject_reason = booking_reject_params[:reject_reason]

      if booking_by_id.rejected!
        BookingMailer.booking_rejected_email(booking_by_id).deliver_now
        redirect_to admin_bookings_path, notice: I18n.t('booking.rejected', date: booking_by_id.date)
      else
        render :edit
      end
    end

    private

    def booking_params
      params.require(:booking).permit(:id, :table_id, :user_id, :date, :status, customer_attributes: [:first_name, :last_name, :email])
    end

    def booking_reject_params
      params.require(:booking).permit(:reject_reason)
    end

    def reject_reason_not_present
      redirect_to admin_booking_path(booking_by_id), alert: I18n.t('activerecord.errors.reject_reason_present')
    end
  end
end
