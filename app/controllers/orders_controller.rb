class OrdersController < ApplicationController
  include OrdersHelper
  
  def index
    if current_user
      @orders = current_user.orders
    else
      redirect_to root_path
    end
  end

  def create
    @order = OrderGenerator.generate(@cart, current_user)
    if @order.save && !@cart.contents.empty?
      session[:cart] = {}
      flash[:success] = "Order was successfully placed!"
      if current_user.email
        UserNotifier.send_confirmation(current_user).deliver_now
        flash[:success] += " An email has been sent to: #{current_user.email}"
        flash[:success] += " Our drone will deliver your produce soon!"
      end
      redirect_to order_path(@order.id)
    else
      flash[:danger] = "You can't check out with an empty cart."
      redirect_to "/cart"
    end
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    render file: "public/404" unless @order
  end

  def update
    if current_user.store
      store = Store.find(current_user.store.id)
      @order = store.orders.find(params[:id])
      @order.update(drone: params[:drone].to_i)
      Drone.request_drone if launch_drone?
      redirect_to admin_order_path(@order.id)
    else
      @order = current_user.orders.find(params[:id])
      if params[:drone]
        @order.update(drone: params[:drone].to_i)
        flash[:success] = "Order ##{@order.id} is #{@order.drone}."
        redirect_to order_path(@order.id)
      else
        @order.update(status: params[:status])
        flash[:success] = "Order ##{@order.id} has been #{@order.status}."
        redirect_to dashboard_path
      end
    end
  end
end
