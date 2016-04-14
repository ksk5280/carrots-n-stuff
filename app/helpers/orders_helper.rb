module OrdersHelper

  def launch_drone?
    params[:drone].to_i == 3
  end
end
