class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ActionView::Helpers::NumberHelper

  before_action :set_cart, :set_top_categories
  helper_method :current_user
  # helper_method :current_admin?
  helper_method :format_price
  helper_method :user_orders_path
  # helper_method :require_admin

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def require_admin
  #   render file: "public/404" unless current_admin?
  # end
  #
  # def current_admin?
  #   current_user && current_user.admin?
  # end

  def user_orders_path
    # if current_admin?
    #   admin_orders_path
    # else
      orders_path
    # end
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def set_top_categories
    @top_categories ||= Category.take(4)
  end

  def format_price(price)
    number_to_currency(price.to_f / 100)
  end
end
