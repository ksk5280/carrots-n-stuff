class ItemsController < ApplicationController
  def index
    @items = Item.all_for_active_stores
  end
end
