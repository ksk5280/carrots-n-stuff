gbclass CartItemsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    status, message = @cart.update_quantity(params[:subtract], @item)
    flash[status] = message
    session[:cart] = @cart.contents
    redirect_to :back
  end

  def index
    @cart_contents = @cart.fetch_items
  end

  def destroy
    @item = Item.find(params[:id])

    message = "Successfully removed <a href=\"#{item_path(@item.id)}\""\
    "class=\"alert-link\">#{@item.title}</a> from your cart."

    @cart.remove_item(@item.id)
    flash[:success] = message

    redirect_to cart_path
  end
end
