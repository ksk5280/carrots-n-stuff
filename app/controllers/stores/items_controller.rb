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
    @categories = Category.all
    @item.categories = Category.all.select do |category|
      params[category.title] == "1"
    end
    if @item.save
      flash[:alert] = "Item successfully created!"
      redirect_to dashboard_path(current_user)
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
    # if @item.save
      flash[:alert] = "Item updated successfully."
      redirected_to dashboard_path(current_user)
    else
      flash.now[:alert] = "Something went wrong."
      render :edit
    end
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :price, :categories, :store_id)
    end
end
