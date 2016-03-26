class StoresController < ApplicationController

  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = current_user.stores.new(store_params)
    if @store.save
      current_user.roles << Role.find_by(name: "store_admin")
      flash[:alert] = "Store successfully requested."
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Something went wrong!"
      render :new
    end
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    @store = Store.find(params[:id])
    @store.update_attributes(store_params)
    if @store.save
      flash[:alert] = "Store successufully updated."
      redirect_to dashboard_path
    else
      flash.now[:alert] = "Something went wrong!"
      render :edit
    end
  end

  private

    def store_params
      params.require(:store).permit(:name, :description, :image_url)
    end
end
