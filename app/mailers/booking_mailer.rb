class BookingMailer < ApplicationMailer
  default from: 'notifications@restbook.com'

  def booking_accepted_email(booking)
    @booking = booking
    mail(to: @booking.customer.email, subject: 'Your table booking has been accepted!')
  end

  def booking_rejected_email(booking)
    @booking = booking
    mail(to: @booking.customer.email, subject: 'Your table booking has been rejected.')
  end
end
