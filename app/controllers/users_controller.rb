class UsersController < ApplicationController
  before_action :set_user, except: [:create, :new, :update]

  def create
    @user = User.new(user_params)
    @user.roles << Role.find_by(name: "registered_user")
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Logged in as #{@user.username}"
      redirect_to dashboard_path
    else
      flash[:danger] = "Invalid account details. Please try again."
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show
    @orders = Order.all
    #TODO link order with store
    @stores = Store.all
    @categories = Category.all
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.store_admin? && params[:status] == "1"
      user = User.find(params[:user_id].to_i)
      user.update_attribute("status", params[:status].to_i)
      user.roles << Role.find_by(name: "store_manager")
      flash[:success] = "#{user.first_name} #{user.last_name} is now a #{user.store.name} team member."
      redirect_to dashboard_path
    elsif params[:status] == "0"
      current_user.update_attribute("status", params[:status].to_i)
      current_user.update_attribute("store_id", params[:store_id])
      flash[:success] = "Your application has been submitted."
      store = Store.find(params[:store_id])
      redirect_to store_root_path(store.slug)
    elsif params[:status] == "2"
      user = User.find(params[:user_id].to_i)
      user.update_attribute("status", nil)
      UserRole.where(user_id: user.id).find_by(role_id: Role.find_by(name: "store_manager").id).destroy
      flash[:success] = "#{user.first_name} #{user.last_name} has been fired"
      redirect_to dashboard_path
    else
      @user.update(user_params)
      if @user.save
        flash[:success] = "Account successfully updated."
        redirect_to dashboard_path
      else
        flash[:danger] = @user.errors.full_messages.join(", ")
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username,
                                 :password,
                                 :first_name,
                                 :last_name,
                                 :address,
                                 :email,
                                 :status,
                                 :store_id)
  end

  def set_user
    @user = current_user
  end
end
