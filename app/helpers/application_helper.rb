module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def format_price(price)
    number_to_currency(price.to_f / 100)
  end
end
