class DishDecorator < Draper::Decorator
  delegate_all

  def vat_with_percent
    "#{object.vat} %"
  end

  def price_with_currency
    "#{object.price} PLN"
  end

  def net_price_with_currency
    "#{object.net_price} PLN"
  end

  def weight_with_unit
    "#{object.weight} g"
  end
end
