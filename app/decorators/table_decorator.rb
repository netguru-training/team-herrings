class TableDecorator < Draper::Decorator
  delegate_all

  def formatted_places
    I18n.translate :places, count: places
  end
end
