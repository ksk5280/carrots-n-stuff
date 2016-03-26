class Stores::ItemsController < Stores::StoresController

  def index
    @items = current_store.items
  end

  def show
    @item = current_store.items.find_by(id: params[:id])
  end

  def new
    @item = current_store.items.new
    @categories = Category.all
  end

  def create
    @item = current_store.items.new(item_params)
    # @item.store_id = current_store.id
    @categories = Category.all
    @item.categories = Category.all.select do |category|
      params[category.title] == "1"
    end
    if @item.save
      flash[:alert] = "Item successfully created!"
      redirect_to dashboard_path(tab: "store_info")
    else
      flash.now[:alert] = "Something went terribly wrong!"
      render :new
    end
  end

  def edit
    @item = current_store.items.find_by(id: params[:id])
    @categories = Category.all
  end

  def update

    @item = current_store.items.find_by(id: params[:id])
    @categories = Category.all
    if @item.update_attributes(item_params)
      flash[:alert] = "Item updated successfully."
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Something went wrong."
      render :edit
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :categories)
    end
end
