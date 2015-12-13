class BookingDecorator < Draper::Decorator
  delegate_all

  def reservation_date
    object.date.strftime("%d-%m-%y %H:%M")
  end

end
