class StoresController < ApplicationController
  include StoresHelper

  def index
    @stores = Store.all_active
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    if @store.save
      current_user.update_attribute("store_id", @store.id)
      current_user.roles << Role.find_by(name: "store_admin")
      flash[:success] = "Store successfully requested."
      redirect_to dashboard_path
    else
      flash.now[:danger] = @store.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @store = Store.find_by(slug: params[:slug])
  end

  def update
    if current_user.platform_admin? && params[:status]
      @store = Store.find(params[:id])
      @store.status = params[:status].to_i
      store_save_status(@store)
      redirect_to dashboard_path
    else
      @store = current_user.store
      @store.update_attributes(store_params)
      store_save_edit(@store)
      render :edit if flash.now[:danger]
      redirect_to dashboard_path if flash[:success]
    end
  end

  def destroy
    store = Store.find_by(slug: params[:id])
    store.destroy
    UserRole.where(user_id: current_user.id).find_by(role_id: Role.find_by(name: "store_admin").id).destroy
    flash[:success] = "Store has been successfully deleted."
    redirect_to dashboard_path
  end

  private

  def store_params
    params.require(:store).permit(:name, :description, :image_url)
  end
end
