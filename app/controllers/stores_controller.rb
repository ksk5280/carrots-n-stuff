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
      flash[:alert] = "Store successfully created."
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
    # kinda sorta functional
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
      params.require(:store).permit(:name)
    end
end
