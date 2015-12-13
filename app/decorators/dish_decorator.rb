class DishDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper
  delegate_all

  def vat_with_percent
    "#{object.vat} %"
  end

  def price_with_currency
    number_to_currency(object.price, locale: :pl)
  end

  def net_price_with_currency
    number_to_currency(object.net_price, locale: :pl)
  end

  def weight_with_unit
    "#{object.weight} g"
  end
end
