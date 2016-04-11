class UserStatusManager
  attr_reader :user, :params

  def initialize(current_user, params)
    @user = current_user
    @params = params
  end

  def status_parse
    return submit_application if params[:status] == "0"
    return hire_manager if user.store_admin? && params[:status] == "1"
    return fire_manager if params[:status] == "2"
  end

  def submit_application
    user.update_attribute("status", params[:status].to_i)
    user.update_attribute("store_id", params[:store_id])
    store = Store.find(params[:store_id])
    path = "/#{store.slug}"
    flash = "Your application has been submitted."
    return [path, flash]
  end

  def hire_manager
    employee = User.find(params[:user_id].to_i)
    employee.update_attribute("status", params[:status].to_i)
    employee.roles << Role.find_by(name: "store_manager")
    path = "/dashboard"
    flash = "#{employee.first_name} #{employee.last_name} is now a #{employee.store.name} team member."
    return [path, flash]
  end

  def fire_manager
    employee = User.find(params[:user_id].to_i)
    employee.update_attribute("status", nil)
    UserRole.where(user_id: employee.id).find_by(role_id: Role.find_by(name: "store_manager").id).destroy
    path = "/dashboard"
    flash = "#{employee.first_name} #{employee.last_name} has been fired"
    return [path, flash]
  end
end
