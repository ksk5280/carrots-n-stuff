class Stores::ItemsController < Stores::StoresController

  def index
    @items = current_store.items
  end
end
